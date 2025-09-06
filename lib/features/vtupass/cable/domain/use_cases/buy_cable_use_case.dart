import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';

import '../../cable.dart';

class BuyCableUseCase implements UseCase<Map, BuyCableUseParams> {
  final CableRepository repository;

  BuyCableUseCase({required this.repository});
  @override
  Future<Either<Failure, Map>> call(BuyCableUseParams param) async {
    return await repository.buyCable(
      provider: param.provider,
      phone: param.phone,
      smartcardNumber: param.smartcardNumber,
      variationCode: param.variationCode,
    );
  }
}

class BuyCableUseParams {
  final String provider;
  final String variationCode;
  final String smartcardNumber;
  final String phone;

  BuyCableUseParams({
    required this.provider,
    required this.variationCode,
    required this.smartcardNumber,
    required this.phone,
  });
}
