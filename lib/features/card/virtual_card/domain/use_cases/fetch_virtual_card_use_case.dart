import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../virtual_card.dart';

class FetchVirtualCardUseCase implements UseCase<List<Card>, NoParam> {
  final FetchVirtualCardRepositories fetchVirtualCardRepositories;

  FetchVirtualCardUseCase({required this.fetchVirtualCardRepositories});

  @override
  Future<Either<Failure, List<Card>>> call(NoParam param) async {
    return await fetchVirtualCardRepositories.fetchAllVirtualCards();
  }
}
