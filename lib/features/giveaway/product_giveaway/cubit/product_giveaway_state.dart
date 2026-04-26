part of 'product_giveaway_cubit.dart';

enum ProductGiveawayStatus {
  initial,
  loading,
  loaded,
  claimed,
  success,
  failed;

  bool get isLoading => this == ProductGiveawayStatus.loading;
  bool get isFailed => this == ProductGiveawayStatus.failed;
  bool get isLoaded => this == ProductGiveawayStatus.loaded;
  bool get isClaimed => this == ProductGiveawayStatus.claimed;
  bool get isBookingSuccess => this == ProductGiveawayStatus.success;
}

class ProductGiveawayState extends Equatable {
  final ProductGiveawayStatus status;
  final String message;
  final List<ProductGiveawayModel> products;
  final FullName fullName;
  final Phone phone;
  final String? state;
  final HouseAddress houseAddress;

  const ProductGiveawayState._({
    required this.status,
    required this.message,
    required this.products,
    required this.fullName,
    required this.phone,
    required this.state,
    required this.houseAddress,
  });

  ProductGiveawayState.initial({required AppUser user})
    : this._(
        status: ProductGiveawayStatus.initial,
        message: '',
        products: const [],
        state: null,
        fullName: FullName.pure(user.fullName),
        phone: Phone.pure(user.phone),
        houseAddress: const HouseAddress.pure(),
      );

  ProductGiveawayState copyWith({
    ProductGiveawayStatus? status,
    String? message,
    List<ProductGiveawayModel>? products,
    FullName? fullName,
    Phone? phone,
    String? state,
    HouseAddress? houseAddress,
  }) {
    return ProductGiveawayState._(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      state: state ?? this.state,
      fullName: fullName ?? this.fullName,
      houseAddress: houseAddress ?? this.houseAddress,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [
    products,
    status,
    message,
    fullName,
    phone,
    state,
    houseAddress,
  ];
}
