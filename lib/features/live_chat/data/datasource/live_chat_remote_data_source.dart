import 'dart:convert';

import 'package:app_client/app_client.dart';
import 'package:super_cash/features/live_chat/live_chat.dart';

abstract interface class LiveChatRemoteDataSource {
  Future<List<LiveChatChannel>> fetchSupports();
}

class LiveChatRemoteDataSourceImpl implements LiveChatRemoteDataSource {
  final AuthClient apiClient;

  const LiveChatRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<List<LiveChatChannel>> fetchSupports() async {
    final response = await apiClient.request(
      method: 'GET',
      path: 'core/support/channels',
    );

    final decoded = jsonDecode(response.body);
    List<dynamic>? data;

    if (decoded is List) {
      data = decoded;
    } else if (decoded is Map<String, dynamic>) {
      if (decoded['results'] is List) {
        data = decoded['results'] as List;
      } else if (decoded['data'] is List) {
        data = decoded['data'] as List;
      }
    }

    if (data == null) return [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(LiveChatChannel.fromJson)
        .toList();
  }
  
}
