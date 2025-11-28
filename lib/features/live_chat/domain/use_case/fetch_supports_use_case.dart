import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/live_chat/domain/domain.dart';

class FetchSupportsUseCase implements UseCase<List<LiveChatChannel>, NoParam> {
  final LiveChatRepository liveChatRepository;

  const FetchSupportsUseCase({required this.liveChatRepository});

  @override
  Future<Either<Failure, List<LiveChatChannel>>> call(NoParam param) async {
    return await liveChatRepository.fetchSupports();
  }
}
