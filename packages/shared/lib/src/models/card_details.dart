// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

String _stringFromJson(dynamic value) => value?.toString() ?? '';

double _doubleFromJson(dynamic value) =>
    double.tryParse(value.toString()) ?? 0.0;

bool _boolFromJson(dynamic value) {
  if (value is bool) return value;
  return value?.toString().toLowerCase() == 'true';
}

class CardDetailsResponse {
  CardDetailsResponse({
    required this.status,
    required this.data,
  });

  factory CardDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CardDetailsResponse(
      status: json['status'] as String,
      data: CardDetails.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
  final String status;
  final CardDetails data;

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data.toJson(),
      };
}

class CardDetails {
  CardDetails({
    required this.id,
    required this.displayName,
    required this.brand,
    required this.cardType,
    required this.currency,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.balance,
    required this.status,
    required this.statusDisplay,
    required this.isActive,
    required this.isFrozen,
    required this.isDeleted,
    required this.providerName,
    required this.issuedAt,
    required this.createdAt,
    required this.firstSix,
    required this.masked,
    required this.cardNumber,
    required this.cvv,
    required this.billingAddress,
    required this.customerId,
    required this.cardName,
    required this.terminate,
    required this.terminateDate,
    required this.updatedAt,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'] as Map<String, dynamic>?;
    final terminateDate = json['terminate_date'] as String?;

    return CardDetails(
      id: _stringFromJson(json['id']),
      displayName: _stringFromJson(json['display_name']),
      brand: _stringFromJson(json['brand']),
      cardType: _stringFromJson(json['card_type']),
      currency: _stringFromJson(json['currency']),
      last4: _stringFromJson(json['last4']),
      expiryMonth: _stringFromJson(json['expiry_month']),
      expiryYear: _stringFromJson(json['expiry_year']),
      balance: _doubleFromJson(json['balance']),
      status: _stringFromJson(json['status']),
      statusDisplay: _stringFromJson(json['status_display']),
      isActive: _boolFromJson(json['is_active']),
      isFrozen: _boolFromJson(json['is_frozen']),
      isDeleted: _boolFromJson(json['is_deleted']),
      providerName: _stringFromJson(json['provider_name']),
      issuedAt: DateTime.parse(json['issued_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      firstSix: _stringFromJson(json['first_six']),
      masked: _stringFromJson(json['masked']),
      cardNumber: _stringFromJson(json['card_number']),
      cvv: _stringFromJson(json['ccv']),
      billingAddress: BillingAddress.fromJson(
        json['billing'] as Map<String, dynamic>,
      ),
      customerId: _stringFromJson(customer?['id']),
      cardName: _stringFromJson(customer?['name']),
      terminate: _boolFromJson(json['terminate']),
      terminateDate:
          terminateDate == null ? null : DateTime.parse(terminateDate),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  final String id;
  final String displayName;
  final String brand;
  final String cardType;
  final String currency;
  final String last4;
  final String expiryMonth;
  final String expiryYear;
  final double balance;
  final String status;
  final String statusDisplay;
  final bool isActive;
  final bool isFrozen;
  final bool isDeleted;
  final String providerName;
  final DateTime issuedAt;
  final DateTime createdAt;
  final String firstSix;
  final String masked;
  final String cardNumber;
  final String cvv;
  final BillingAddress billingAddress;
  final String customerId;
  final String cardName;
  final bool terminate;
  final DateTime? terminateDate;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'display_name': displayName,
        'brand': brand,
        'card_type': cardType,
        'currency': currency,
        'last4': last4,
        'expiry_month': expiryMonth,
        'expiry_year': expiryYear,
        'balance': balance,
        'status': status,
        'status_display': statusDisplay,
        'is_active': isActive,
        'is_frozen': isFrozen,
        'is_deleted': isDeleted,
        'provider_name': providerName,
        'issued_at': issuedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'first_six': firstSix,
        'masked': masked,
        'card_number': cardNumber,
        'ccv': cvv,
        'billing': billingAddress.toJson(),
        'customer': {'id': customerId, 'name': cardName},
        'terminate': terminate,
        'terminate_date': terminateDate?.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  String get formattedExpiryDate {
    final shortYear = expiryYear.length > 2
        ? expiryYear.substring(expiryYear.length - 2)
        : expiryYear;
    return '$expiryMonth/$shortYear';
  }

  CardDetails copyWith({
    String? id,
    String? displayName,
    String? brand,
    String? cardType,
    String? currency,
    String? last4,
    String? expiryMonth,
    String? expiryYear,
    double? balance,
    String? status,
    String? statusDisplay,
    bool? isActive,
    bool? isFrozen,
    bool? isDeleted,
    String? providerName,
    DateTime? issuedAt,
    DateTime? createdAt,
    String? firstSix,
    String? masked,
    String? cardNumber,
    String? cvv,
    BillingAddress? billingAddress,
    String? customerId,
    String? cardName,
    bool? terminate,
    DateTime? terminateDate,
    DateTime? updatedAt,
  }) {
    return CardDetails(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      brand: brand ?? this.brand,
      cardType: cardType ?? this.cardType,
      currency: currency ?? this.currency,
      last4: last4 ?? this.last4,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      statusDisplay: statusDisplay ?? this.statusDisplay,
      isActive: isActive ?? this.isActive,
      isFrozen: isFrozen ?? this.isFrozen,
      isDeleted: isDeleted ?? this.isDeleted,
      providerName: providerName ?? this.providerName,
      issuedAt: issuedAt ?? this.issuedAt,
      createdAt: createdAt ?? this.createdAt,
      firstSix: firstSix ?? this.firstSix,
      masked: masked ?? this.masked,
      cardNumber: cardNumber ?? this.cardNumber,
      cvv: cvv ?? this.cvv,
      billingAddress: billingAddress ?? this.billingAddress,
      customerId: customerId ?? this.customerId,
      cardName: cardName ?? this.cardName,
      terminate: terminate ?? this.terminate,
      terminateDate: terminateDate ?? this.terminateDate,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BillingAddress {
  const BillingAddress({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
  });

  const BillingAddress.appleProductBillingAddress()
      : this(
          address: 'Calle 74 Este, San Francisco',
          city: 'Ciudad de Panama',
          country: 'PANAMA',
          postalCode: '0401',
          state: 'Panama',
        );

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      address: _stringFromJson(json['address']),
      country: _stringFromJson(json['country']),
      state: _stringFromJson(json['state']),
      city: _stringFromJson(json['city']),
      postalCode: _stringFromJson(json['postal_code']),
    );
  }
  final String address;
  final String country;
  final String state;
  final String city;
  final String postalCode;

  Map<String, dynamic> toJson() => {
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'postal_code': postalCode,
      };
}

// Extension with helper methods
extension CardDetailsExtensions on CardDetails {
  String get maskedCardNumber => '•••• $last4';

  bool get isExpired {
    final now = DateTime.now();
    final year = expiryYear.length == 2
        ? 2000 + int.parse(expiryYear)
        : int.parse(expiryYear);
    final expiryDate = DateTime(year, int.parse(expiryMonth));
    return now.isAfter(expiryDate);
  }

  String get formattedBalance => _formatCurrency(balance);

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: r'$',
      decimalDigits: 2,
      locale: 'en_US',
    );
    return formatter.format(amount);
  }
}
