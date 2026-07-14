// ignore_for_file: public_member_api_docs

String _stringFromJson(dynamic value) => value?.toString() ?? '';

double _doubleFromJson(dynamic value) =>
    double.tryParse(value.toString()) ?? 0.0;

class CardTransactionsResponse {
  CardTransactionsResponse({
    required this.status,
    required this.transactions,
    this.meta,
  });

  factory CardTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return CardTransactionsResponse(
      status: _stringFromJson(json['status']),
      transactions: (json['data'] as List<dynamic>? ?? [])
          .map((e) => CardTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }
  final String status;
  final List<CardTransaction> transactions;
  final PaginationMeta? meta;
}

class CardTransaction {
  const CardTransaction({
    required this.currency,
    required this.name,
    required this.number,
    required this.masked,
    required this.balance,
    required this.status,
    required this.refId,
    required this.refType,
    required this.amount,
    required this.createdAt,
    required this.transId,
    required this.description,
  });

  factory CardTransaction.fromJson(Map<String, dynamic> json) {
    return CardTransaction(
      currency: _stringFromJson(json['currency']),
      name: _stringFromJson(json['name']),
      number: _stringFromJson(json['number']),
      masked: _stringFromJson(json['masked']),
      balance: _doubleFromJson(json['balance']),
      status: _stringFromJson(json['status']),
      refId: _stringFromJson(json['ref_id']),
      refType: _stringFromJson(json['ref_type']),
      amount: _stringFromJson(json['amount']),
      createdAt: DateTime.parse(json['created_at'] as String),
      transId: _stringFromJson(json['trans_id']),
      description: _stringFromJson(json['description']),
    );
  }
  final String currency;
  final String name;
  final String number;
  final String masked;
  final double balance;
  final String status;
  final String refId;
  final String refType;
  final String amount;
  final DateTime createdAt;
  final String transId;
  final String description;

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'name': name,
      'number': number,
      'masked': masked,
      'balance': balance,
      'status': status,
      'ref_id': refId,
      'ref_type': refType,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'trans_id': transId,
      'description': description,
    };
  }

  String get formattedAmount => '\$$amount';
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
      total: map['total'] as int? ?? 0,
      pages: map['pages'] as int? ?? 0,
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
