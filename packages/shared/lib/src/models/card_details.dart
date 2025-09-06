// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

class CardDetailsResponse {
  CardDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CardDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CardDetailsResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: CardDetails.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
  final String status;
  final String message;
  final CardDetails data;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };
}

class CardDetails {
  CardDetails({
    required this.cardId,
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.last4,
    required this.cardCurrency,
    required this.brand,
    required this.billingAddress,
    required this.cardName,
    required this.cardholderId,
    required this.createdAt,
    required this.issuingAppId,
    required this.cardType,
    required this.isActive,
    required this.livemode,
    required this.metaData,
    required this.blockedDueToFraud,
    required this.currentCardLimit,
    required this.isDeleted,
    required this.balance,
    required this.availableBalance,
    required this.bookBalance,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    // Helper function to convert cents to dollars
    double centsToDollars(String cents) {
      final centsValue = int.tryParse(cents) ?? 0;
      return centsValue / 100;
    }

    return CardDetails(
      cardId: json['card_id'] as String,
      cardNumber: json['card_number'] as String,
      expiryMonth: json['expiry_month'] as String,
      expiryYear: json['expiry_year'] as String,
      cvv: json['cvv'] as String,
      last4: json['last_4'] as String,
      cardCurrency: json['card_currency'] as String,
      brand: json['brand'] as String,
      billingAddress: BillingAddress.fromJson(
        json['billing_address'] as Map<String, dynamic>,
      ),
      cardName: json['card_name'] as String,
      cardholderId: json['cardholder_id'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (json['created_at'] as int) * 1000,
      ),
      issuingAppId: json['issuing_app_id'] as String,
      cardType: json['card_type'] as String,
      isActive: json['is_active'] as bool,
      livemode: json['livemode'] as bool,
      metaData: MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
      blockedDueToFraud: json['blocked_due_to_fraud'] as bool,
      currentCardLimit: json['current_card_limit'] as String,
      isDeleted: json['is_deleted'] as bool,
      balance: centsToDollars(json['balance'] as String),
      availableBalance: centsToDollars(json['available_balance'] as String),
      bookBalance: centsToDollars(json['book_balance'] as String),
    );
  }
  final String cardId;
  final String cardNumber;
  final String expiryMonth;
  final String expiryYear;
  final String cvv;
  final String last4;
  final String cardCurrency;
  final String brand;
  final BillingAddress billingAddress;
  final String cardName;
  final String cardholderId;
  final DateTime createdAt;
  final String issuingAppId;
  final String cardType;
  final bool isActive;
  final bool livemode;
  final MetaData metaData;
  final bool blockedDueToFraud;
  final String currentCardLimit;
  final bool isDeleted;
  final double balance;
  final double availableBalance;
  final double bookBalance;
  bool get isPlatinum => currentCardLimit == '1000000';

  Map<String, dynamic> toJson() {
    // Helper function to convert dollars back to cents
    String dollarsToCents(double dollars) {
      return (dollars * 100).round().toString();
    }

    return {
      'card_id': cardId,
      'card_number': cardNumber,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'cvv': cvv,
      'last_4': last4,
      'card_currency': cardCurrency,
      'brand': brand,
      'billing_address': billingAddress.toJson(),
      'card_name': cardName,
      'cardholder_id': cardholderId,
      'created_at': createdAt.millisecondsSinceEpoch ~/ 1000,
      'issuing_app_id': issuingAppId,
      'card_type': cardType,
      'is_active': isActive,
      'livemode': livemode,
      'meta_data': metaData.toJson(),
      'blocked_due_to_fraud': blockedDueToFraud,
      'current_card_limit': currentCardLimit,
      'is_deleted': isDeleted,
      'balance': dollarsToCents(balance),
      'available_balance': dollarsToCents(availableBalance),
      'book_balance': dollarsToCents(bookBalance),
    };
  }

  String get formattedExpiryDate => '$expiryMonth/${expiryYear.substring(2)}';

  CardDetails copyWith({
    String? cardId,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? last4,
    String? cardCurrency,
    String? brand,
    BillingAddress? billingAddress,
    String? cardName,
    String? cardholderId,
    DateTime? createdAt,
    String? issuingAppId,
    String? cardType,
    bool? isActive,
    bool? livemode,
    MetaData? metaData,
    bool? blockedDueToFraud,
    String? currentCardLimit,
    bool? isDeleted,
    double? balance,
    double? availableBalance,
    double? bookBalance,
  }) {
    return CardDetails(
      cardId: cardId ?? this.cardId,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvv: cvv ?? this.cvv,
      last4: last4 ?? this.last4,
      cardCurrency: cardCurrency ?? this.cardCurrency,
      brand: brand ?? this.brand,
      billingAddress: billingAddress ?? this.billingAddress,
      cardName: cardName ?? this.cardName,
      cardholderId: cardholderId ?? this.cardholderId,
      createdAt: createdAt ?? this.createdAt,
      issuingAppId: issuingAppId ?? this.issuingAppId,
      cardType: cardType ?? this.cardType,
      isActive: isActive ?? this.isActive,
      livemode: livemode ?? this.livemode,
      metaData: metaData ?? this.metaData,
      blockedDueToFraud: blockedDueToFraud ?? this.blockedDueToFraud,
      currentCardLimit: currentCardLimit ?? this.currentCardLimit,
      isDeleted: isDeleted ?? this.isDeleted,
      balance: balance ?? this.balance,
      availableBalance: availableBalance ?? this.availableBalance,
      bookBalance: bookBalance ?? this.bookBalance,
    );
  }
}

class BillingAddress {
  const BillingAddress({
    required this.billingAddress1,
    required this.billingCity,
    required this.billingCountry,
    required this.billingZipCode,
    required this.countryCode,
    required this.state,
    required this.stateCode,
  });

  const BillingAddress.appleProductBillingAddress()
      : this(
          billingAddress1: 'Calle 74 Este, San Francisco',
          billingCity: 'Ciudad de Panama',
          billingCountry: 'PANAMA',
          billingZipCode: '0401',
          countryCode: 'PA',
          state: 'Panama',
          stateCode: 'Pa',
        );

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      billingAddress1: json['billing_address1'] as String,
      billingCity: json['billing_city'] as String,
      billingCountry: json['billing_country'] as String,
      billingZipCode: json['billing_zip_code'] as String,
      countryCode: json['country_code'] as String,
      state: json['state'] as String,
      stateCode: json['state_code'] as String,
    );
  }
  final String billingAddress1;
  final String billingCity;
  final String billingCountry;
  final String billingZipCode;
  final String countryCode;
  final String state;
  final String stateCode;

  Map<String, dynamic> toJson() => {
        'billing_address1': billingAddress1,
        'billing_city': billingCity,
        'billing_country': billingCountry,
        'billing_zip_code': billingZipCode,
        'country_code': countryCode,
        'state': state,
        'state_code': stateCode,
      };

  String get formattedAddress =>
      '$billingAddress1, $billingCity, $state $billingZipCode, $billingCountry';
}

class MetaData {
  MetaData({
    required this.cardBrand,
    required this.cardLimit,
    required this.reference,
    required this.userId,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      cardBrand: json['card_brand'] as String?,
      cardLimit: json['card_limit'] as String?,
      reference: json['reference'] as String?,
      userId: json['user_id'] as String?,
    );
  }
  final String? cardBrand;
  final String? cardLimit;
  final String? reference;
  final String? userId;

  Map<String, dynamic> toJson() => {
        'card_brand': cardBrand,
        'card_limit': cardLimit?.toString(),
        'reference': reference,
        'user_id': userId,
      };
}

// Extension with helper methods
extension CardDetailsExtensions on CardDetails {
  String get maskedCardNumber => '•••• $last4';

  bool get isExpired {
    final now = DateTime.now();
    final expiryDate = DateTime(
      int.parse(expiryYear),
      int.parse(expiryMonth),
    );
    return now.isAfter(expiryDate);
  }

  String get formattedBalance => _formatCurrency(balance);
  String get formattedAvailableBalance => _formatCurrency(availableBalance);
  String get formattedBookBalance => _formatCurrency(bookBalance);
  // String get formattedCurrentLimit => _formatCurrency(currentCardLimit);

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: r'$',
      decimalDigits: 2,
      locale: 'en_US',
    );
    return formatter.format(amount);
  }
}
