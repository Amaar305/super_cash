import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  DioClient(this.dio, this.sharedPreferences) {
    dio
      ..options.baseUrl = 'http://127.0.0.1:8000/api/v1/'
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 3)
      ..options.headers = {'Content-Type': 'application/json'}
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            final accessToken = sharedPreferences.getString('accessToken');
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
            return handler.next(options);
          },
          onError: (DioException e, ErrorInterceptorHandler handler) async {
            if (e.response?.statusCode == 401) {
              final refreshToken = sharedPreferences.getString('refreshToken');
              if (refreshToken != null) {
                try {
                  final response = await dio.post('auth/refresh-token', data: {
                    'refreshToken': refreshToken,
                  });
                  final newAccessToken = response.data['accessToken'];
                  final newRefreshToken = response.data['refreshToken'];

                  await sharedPreferences.setString(
                      'accessToken', newAccessToken);
                  await sharedPreferences.setString(
                      'refreshToken', newRefreshToken);

                  // Retry the original request with the new access token
                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newAccessToken';
                  final retryResponse = await dio.request(
                    e.requestOptions.path,
                    options: e.requestOptions as Options,
                  );
                  return handler.resolve(retryResponse);
                } catch (refreshError) {
                  // If refresh token fails, send a 401 to the bloc, and let the bloc handle it
                  return handler.next(e);
                }
              }
            }
            return handler.next(e);
          },
        ),
      );
  }

  // Add methods for making API calls (get, post, put, delete)
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return dio.post(path, data: data, queryParameters: queryParameters);
  }
  // Implement other methods
}
