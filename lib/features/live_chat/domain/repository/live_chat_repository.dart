import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/features/live_chat/live_chat.dart';

abstract interface class LiveChatRepository {
  Future<Either<Failure, List<LiveChatChannel>>> fetchSupports();
}