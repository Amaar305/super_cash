import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/live_chat/live_chat.dart';

class LiveChatRepositoryImpl implements LiveChatRepository {
  final LiveChatRemoteDataSource liveChatRemoteDataSource;
  final ApiErrorHandler apiErrorHandler;

  const LiveChatRepositoryImpl({
    required this.liveChatRemoteDataSource,
    required this.apiErrorHandler,
  });
  @override
  Future<Either<Failure, List<LiveChatChannel>>> fetchSupports() async {
    try {
      final result = await liveChatRemoteDataSource.fetchSupports();
      return right(result);
    } catch (error) {
      return left(apiErrorHandler.handleError(error));
    }
  }
}
