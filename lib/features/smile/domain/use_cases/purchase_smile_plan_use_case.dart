import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

class PurchaseSmilePlanUseCase
    implements UseCase<TransactionResponse, PurchaseSmilePlanParams> {
  final SmileRepository repository;

  const PurchaseSmilePlanUseCase({required this.repository});

  @override
  Future<Either<Failure, TransactionResponse>> call(
    PurchaseSmilePlanParams param,
  ) {
    return repository.purchase(
      email: param.email,
      accountId: param.accountId,
      variationCode: param.variationCode,
      phone: param.phone,
    );
  }
}

class PurchaseSmilePlanParams {
  final String email;
  final String accountId;
  final String variationCode;
  final String phone;

  const PurchaseSmilePlanParams({
    required this.email,
    required this.accountId,
    required this.variationCode,
    required this.phone,
  });
}
