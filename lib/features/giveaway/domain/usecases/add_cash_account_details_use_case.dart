import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddCashAccountDetailsUseCase
    implements
        UseCase<UserCashAccountDetailModel, AddCashAccountDetailsParams> {
  final GiveawayRepository giveawayRepository;

  const AddCashAccountDetailsUseCase({required this.giveawayRepository});

  @override
  Future<Either<Failure, UserCashAccountDetailModel>> call(
    AddCashAccountDetailsParams param,
  ) async {
    return await giveawayRepository.addCashAccountDetails(
      cashId: param.cashId,
      accountName: param.accountName,
      accountNumber: param.accountNumber,
      bankName: param.bankName,
      bankCode: param.bankCode,
      phoneNumber: param.phoneNumber,
    );
  }
}

class AddCashAccountDetailsParams {
  final String cashId;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String? bankCode;
  final String? phoneNumber;

  const AddCashAccountDetailsParams({
    required this.cashId,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    this.bankCode,
    this.phoneNumber,
  });
}
