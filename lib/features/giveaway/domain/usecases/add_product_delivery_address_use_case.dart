import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class AddProductDeliveryAddressUseCase
    implements
        UseCase<ProductClaimAddressModel, AddProductDeliveryAddressParams> {
  final GiveawayRepository giveawayRepository;

  const AddProductDeliveryAddressUseCase({required this.giveawayRepository});
  @override
  Future<Either<Failure, ProductClaimAddressModel>> call(
    AddProductDeliveryAddressParams param,
  ) async {
    return await giveawayRepository.addProductDeliveryAddress(
      productId: param.productId,
      fullName: param.fullName,
      phoneNumber: param.phoneNumber,
      address: param.address,
    );
  }
}

class AddProductDeliveryAddressParams {
  final String productId;
  final String fullName;
  final String phoneNumber;
  final String address;

  const AddProductDeliveryAddressParams({
    required this.productId,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
  });
}
