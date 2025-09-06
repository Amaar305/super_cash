// ignore_for_file: public_member_api_docs

class CardTransactionsResponse {
  CardTransactionsResponse({
    required this.transactions,
    required this.meta,
  });

  factory CardTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return CardTransactionsResponse(
      transactions: (json['transactions'] as List)
          .map((e) => CardTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }
  final List<CardTransaction> transactions;
  final PaginationMeta meta;
}

class CardTransaction {
  const CardTransaction({
    required this.amount,
    required this.bridgecardTransactionReference,
    required this.cardId,
    required this.cardTransactionType,
    required this.cardholderId,
    required this.clientTransactionReference,
    required this.currency,
    required this.description,
    required this.issuingAppId,
    required this.livemode,
    required this.transactionDate,
    required this.transactionTimestamp,
    required this.enrichedData,
    this.merchantCategoryCode,
  });

  factory CardTransaction.fromJson(Map<String, dynamic> json) {
    return CardTransaction(
      amount: json['amount'] as String,
      bridgecardTransactionReference:
          json['bridgecard_transaction_reference'] as String,
      cardId: json['card_id'] as String,
      cardTransactionType: json['card_transaction_type'] as String,
      cardholderId: json['cardholder_id'] as String,
      clientTransactionReference:
          json['client_transaction_reference'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
      issuingAppId: json['issuing_app_id'] as String,
      livemode: json['livemode'] as bool,
      transactionDate: json['transaction_date'] as String,
      transactionTimestamp: json['transaction_timestamp'] as int,
      merchantCategoryCode: json['merchant_category_code'] as String?,
      enrichedData:
          EnrichedData.fromJson(json['enriched_data'] as Map<String, dynamic>),
    );
  }
  final String amount;
  final String bridgecardTransactionReference;
  final String cardId;
  final String cardTransactionType;
  final String cardholderId;
  final String clientTransactionReference;
  final String currency;
  final String description;
  final String issuingAppId;
  final bool livemode;
  final String transactionDate;
  final int transactionTimestamp;
  final String? merchantCategoryCode;
  final EnrichedData enrichedData;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'bridgecard_transaction_reference': bridgecardTransactionReference,
      'card_id': cardId,
      'card_transaction_type': cardTransactionType,
      'cardholder_id': cardholderId,
      'client_transaction_reference': clientTransactionReference,
      'currency': currency,
      'description': description,
      'issuing_app_id': issuingAppId,
      'livemode': livemode,
      'transaction_date': transactionDate,
      'transaction_timestamp': transactionTimestamp,
      'merchant_category_code': merchantCategoryCode,
      'enriched_data': enrichedData.toJson(),
      // 'partner_interchange_fee': partnerInterchangeFee,
      // 'interchange_revenue': interchangeRevenue,
      // 'partner_interchange_fee_refund': partnerInterchangeFeeRefund,
      // 'interchange_revenue_refund': interchangeRevenueRefund,
    };
  }

  String get formattedAmount => '\$$amount';
}

class EnrichedData {
  const EnrichedData({
    required this.isRecurring,
    required this.merchantCity,
    required this.merchantCode,
    required this.merchantLogo,
    required this.merchantName,
    required this.merchantWebsite,
    required this.transactionCategory,
    required this.transactionGroup,
  });

  factory EnrichedData.fromJson(Map<String, dynamic> json) {
    return EnrichedData(
      isRecurring: json['is_recurring'] as bool,
      merchantCity: json['merchant_city'] as String?,
      merchantCode: json['merchant_code'] as String?,
      merchantLogo: json['merchant_logo'] as String?,
      merchantName: json['merchant_name'] as String?,
      merchantWebsite: json['merchant_website'] as String?,
      transactionCategory: json['transaction_category'] as String?,
      transactionGroup: json['transaction_group'] as String?,
    );
  }
  final bool isRecurring;
  final String? merchantCity;
  final String? merchantCode;
  final String? merchantLogo;
  final String? merchantName;
  final String? merchantWebsite;
  final String? transactionCategory;
  final String? transactionGroup;

  Map<String, dynamic> toJson() {
    return {
      'is_recurring': isRecurring,
      'merchant_city': merchantCity,
      'merchant_code': merchantCode,
      'merchant_logo': merchantLogo,
      'merchant_name': merchantName,
      'merchant_website': merchantWebsite,
      'transaction_category': transactionCategory,
      'transaction_group': transactionGroup,
    };
  }
}

class PaginationMeta {
  const PaginationMeta({
    required this.total,
    required this.pages,
    this.next,
    this.previous,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> map) {
    return PaginationMeta(
      total: map['total'] as int,
      pages: map['pages'] as int,
      next: map['next'] != null ? map['next'] as String : null,
      previous: map['previous'] != null ? map['previous'] as String : null,
    );
  }
  final int total;
  final int pages;
  final String? next;
  final String? previous;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'total': total,
      'pages': pages,
      'next': next,
      'previous': previous,
    };
  }
}
