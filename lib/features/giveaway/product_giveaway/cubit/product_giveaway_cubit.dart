import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/giveaway/domain/domain.dart';

part 'product_giveaway_state.dart';

class ProductGiveawayCubit extends Cubit<ProductGiveawayState> {
  final GetProductsGiveawayUseCase _getProductsGiveawayUseCase;
  final ClaimProductGiveawayUseCase _claimProductGiveawayUseCase;
  final AddProductDeliveryAddressUseCase _addProductDeliveryAddressUseCase;
  final String _giveawayTypeId;

  ProductGiveawayCubit({
    required GetProductsGiveawayUseCase getProductsGiveawayUseCase,
    required ClaimProductGiveawayUseCase claimProductGiveawayUseCase,
    required AddProductDeliveryAddressUseCase addProductDeliveryAddressUseCase,
    required String giveawayTypeId,
    required AppUser user,
  }) : _getProductsGiveawayUseCase = getProductsGiveawayUseCase,
       _claimProductGiveawayUseCase = claimProductGiveawayUseCase,
       _addProductDeliveryAddressUseCase = addProductDeliveryAddressUseCase,
       _giveawayTypeId = giveawayTypeId,

       super(ProductGiveawayState.initial(user: user));

  Future<void> getProducts() async {
    try {
      if (isClosed) return;
      emit(state.copyWith(status: ProductGiveawayStatus.loading));

      final res = await _getProductsGiveawayUseCase(NoParam());
      if (isClosed) return;
      res.fold(
        (l) => emit(
          state.copyWith(
            status: ProductGiveawayStatus.failed,
            message: l.message,
          ),
        ),
        (r) {
          emit(
            state.copyWith(
              status: ProductGiveawayStatus.loaded,
              products: r,
              message: '',
            ),
          );
        },
      );
    } catch (error, stackTrace) {
      logE('Failed to fetch products $error', stackTrace: stackTrace);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ProductGiveawayStatus.failed,
          message: 'Failed to fetch products. Try again later.',
        ),
      );
    }
  }

  Future<void> claimProduct(
    String productId,
    void Function(ProductGiveawayModel product)? onClaimed,
  ) async {
    try {
      emit(state.copyWith(status: ProductGiveawayStatus.loading));

      final res = await _claimProductGiveawayUseCase(
        ClaimProductGiveawayParams(
          productId: productId,
          giveawayTypeId: _giveawayTypeId,
        ),
      );
      if (isClosed) return;
      res.fold(
        (failure) => emit(
          state.copyWith(
            status: ProductGiveawayStatus.failed,
            message: failure.message,
          ),
        ),
        (success) {
          emit(
            state.copyWith(
              status: ProductGiveawayStatus.claimed,
              products: state.products.map<ProductGiveawayModel>((item) {
                if (item.id == success.id) {
                  item.copyWith(
                    productQuantityRemaining: success.productQuantityRemaining,
                  );
                }
                return item;
              }).toList(),
            ),
          );

          onClaimed?.call(success);
        },
      );
    } catch (error, stackTrace) {
      logE(
        'Failed to claim product $productId. $error',
        stackTrace: stackTrace,
      );
      if (isClosed) return;

      emit(
        state.copyWith(
          status: ProductGiveawayStatus.failed,
          message: 'Failed to claim product. $productId',
        ),
      );
    }
  }

  /// [FullName] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [FullName] and emmiting new [FullName]
  /// validation state.
  void onFullNameChanged(String newValue) {
    final previousScreenState = state;
    final previousFullNameState = previousScreenState.fullName;
    final shouldValidate = previousFullNameState.invalid;
    final newFullNameState = shouldValidate
        ? FullName.dirty(newValue)
        : FullName.pure(newValue);

    final newScreenState = state.copyWith(fullName: newFullNameState);

    emit(newScreenState);
  }

  /// [FullName] field was unfocused, here is checking if previous state with
  /// [FullName] was valid, in order to indicate it in state after unfocus.
  void onFullNameUnfocused() {
    final previousScreenState = state;
    final previousFullNameState = previousScreenState.fullName;
    final previousFullNameValue = previousFullNameState.value;

    final newFullNameState = FullName.dirty(previousFullNameValue);
    final newScreenState = previousScreenState.copyWith(
      fullName: newFullNameState,
    );
    emit(newScreenState);
  }

  /// [Phone] value was changed, triggering new changes in state. Checking
  /// whether or not value is valid in [LastName] and emmiting new [LastName]
  /// validation state.
  void onPhoneChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? Phone.dirty(newValue)
        : Phone.pure(newValue);

    final newScreenState = state.copyWith(phone: newSurnameState);

    emit(newScreenState);
  }

  void onPhoneUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.phone;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = Phone.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      phone: newUsernameState,
    );
    emit(newScreenState);
  }

  void onSelectState(String? city) {
    if (state.state == city) return;

    emit(state.copyWith(state: city));
  }

  void onHouseAddressChanged(String newValue) {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseAddress;
    final shouldValidate = previousLastNameState.invalid;
    final newSurnameState = shouldValidate
        ? HouseAddress.dirty(newValue)
        : HouseAddress.pure(newValue);

    final newScreenState = state.copyWith(houseAddress: newSurnameState);

    emit(newScreenState);
  }

  void onHouseAddressUnfocused() {
    final previousScreenState = state;
    final previousLastNameState = previousScreenState.houseAddress;
    final previousUsernameValue = previousLastNameState.value;

    final newUsernameState = HouseAddress.dirty(previousUsernameValue);
    final newScreenState = previousScreenState.copyWith(
      houseAddress: newUsernameState,
    );
    emit(newScreenState);
  }

  Future<void> addProductAddress(
    String productId, {
    void Function(ProductClaimAddressModel address)? onSuccess,
  }) async {
    try {
      final fullName = FullName.dirty(state.fullName.value);
      final phone = Phone.dirty(state.phone.value);
      final houseAddress = HouseAddress.dirty(state.houseAddress.value);
      final city = state.state;
      final isFormValid = FormzValid([
        fullName,
        phone,
        houseAddress,
      ]).isFormValid;

      if (city == null) {
        emit(
          state.copyWith(
            status: ProductGiveawayStatus.failed,
            message: 'Please select your current state.',
          ),
        );
        return;
      }

      final newState = state.copyWith(
        phone: phone,
        fullName: fullName,
        houseAddress: houseAddress,
        state: city,
        status: isFormValid ? ProductGiveawayStatus.loading : null,
      );
      emit(newState);
      if (!isFormValid) return;

      final res = await _addProductDeliveryAddressUseCase(
        AddProductDeliveryAddressParams(
          productId: productId,
          fullName: fullName.value,
          phoneNumber: phone.value,
          address: 'State: $city Address: ${houseAddress.value}',
        ),
      );
      if (isClosed) return;

      res.fold(
        (failure) => emit(
          state.copyWith(
            status: ProductGiveawayStatus.failed,
            message: failure.message,
          ),
        ),
        (success) {
          emit(state.copyWith(status: ProductGiveawayStatus.success));
          onSuccess?.call(success);
        },
      );
    } catch (error, stackTrace) {
      logE(
        'Failed to add address for product delivery $error',
        stackTrace: stackTrace,
      );
      if (isClosed) return;

      emit(
        state.copyWith(
          status: ProductGiveawayStatus.failed,
          message: 'Failed to add delivery info.',
        ),
      );
    }
  }
}
