// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'card_detail_cubit.dart';

enum CardDetailStatus {
  initial,
  loading,
  success,
  pinChanged,
  failure;

  bool get isError => this == CardDetailStatus.failure;
  bool get isLoading => this == CardDetailStatus.loading;
  bool get isPinChanged => this == CardDetailStatus.pinChanged;
}

@JsonSerializable()
class CardDetailState extends Equatable {
  final CardDetails? cardDetails;
  final bool isCardDetailsExpanded;
  final bool isCardBillingAddressExpanded;
  final String message;
  final CardDetailStatus status;
  final bool appleProduct;
  final BillingAddress appleBillingAddress;

  const CardDetailState({
    required this.isCardDetailsExpanded,
    required this.isCardBillingAddressExpanded,
    required this.message,
    required this.status,
    required this.appleProduct,
    required this.cardDetails,
    required this.appleBillingAddress
  });

  const CardDetailState.initial()
      : this(
          isCardDetailsExpanded: false,
          isCardBillingAddressExpanded: false,
          message: '',
          status: CardDetailStatus.initial,
          appleProduct: false,
          cardDetails: null,
          appleBillingAddress: const BillingAddress.appleProductBillingAddress()
        );
  factory CardDetailState.fromJson(Map<String, dynamic> json) =>
      _$CardDetailStateFromJson(json);

  @override
  List<Object?> get props => [
        isCardBillingAddressExpanded,
        isCardDetailsExpanded,
        message,
        appleProduct,
        status,
        cardDetails,
        appleBillingAddress,
      ];

  CardDetailState copyWith({
    CardDetails? cardDetails,
    bool? isCardDetailsExpanded,
    bool? isCardBillingAddressExpanded,
    String? message,
    CardDetailStatus? status,
    bool? appleProduct,
    BillingAddress? appleBillingAddress,
  }) {
    return CardDetailState(
      cardDetails: cardDetails ?? this.cardDetails,
      isCardDetailsExpanded: isCardDetailsExpanded ?? this.isCardDetailsExpanded,
      isCardBillingAddressExpanded: isCardBillingAddressExpanded ?? this.isCardBillingAddressExpanded,
      message: message ?? this.message,
      status: status ?? this.status,
      appleProduct: appleProduct ?? this.appleProduct,
      appleBillingAddress: appleBillingAddress ?? this.appleBillingAddress,
    );
  }

  Map<String, dynamic> toJson() => _$CardDetailStateToJson(this);
}
