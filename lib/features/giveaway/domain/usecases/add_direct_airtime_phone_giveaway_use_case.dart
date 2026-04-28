import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddDirectAirtimePhoneGiveawayUseCase
    implements
        UseCase<
          UserDirectAirtimePhoneModel,
          AddDirectAirtimePhoneGiveawayParams
        > {
  final GiveawayRepository giveawayRepository;

  const AddDirectAirtimePhoneGiveawayUseCase({
    required this.giveawayRepository,
  });
  @override
  Future<Either<Failure, UserDirectAirtimePhoneModel>> call(
    AddDirectAirtimePhoneGiveawayParams param,
  ) async {
    return await giveawayRepository.addPhoneForClaimedDirectAirtimeGiveaway(
      airtimeId: param.airtimeId,
      phoneNumber: param.phoneNumber,
    );
  }
}

class AddDirectAirtimePhoneGiveawayParams {
  final String airtimeId;
  final String phoneNumber;

  const AddDirectAirtimePhoneGiveawayParams({
    required this.airtimeId,
    required this.phoneNumber,
  });
}
