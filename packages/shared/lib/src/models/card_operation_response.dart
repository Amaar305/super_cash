// ignore_for_file: public_member_api_docs

String _stringFromJson(dynamic value) => value?.toString() ?? '';

double _doubleFromJson(dynamic value) =>
    double.tryParse(value.toString()) ?? 0.0;

/// Shared response shape for card balance operations (fund, withdraw) that
/// return `{status, message, data: {card_id, amount, new_balance, fee,
/// provider_transaction_id}}`.
class CardOperationResponse {
  CardOperationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CardOperationResponse.fromJson(Map<String, dynamic> json) {
    return CardOperationResponse(
      status: _stringFromJson(json['status']),
      message: _stringFromJson(json['message']),
      data: CardOperationData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
  final String status;
  final String message;
  final CardOperationData data;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };
}

class CardOperationData {
  CardOperationData({
    required this.cardId,
    required this.amount,
    required this.newBalance,
    required this.fee,
    required this.providerTransactionId,
  });

  factory CardOperationData.fromJson(Map<String, dynamic> json) {
    return CardOperationData(
      cardId: _stringFromJson(json['card_id']),
      amount: _doubleFromJson(json['amount']),
      newBalance: _doubleFromJson(json['new_balance']),
      fee: _doubleFromJson(json['fee']),
      providerTransactionId: _stringFromJson(json['provider_transaction_id']),
    );
  }
  final String cardId;
  final double amount;
  final double newBalance;
  final double fee;
  final String providerTransactionId;

  Map<String, dynamic> toJson() => {
        'card_id': cardId,
        'amount': amount,
        'new_balance': newBalance,
        'fee': fee,
        'provider_transaction_id': providerTransactionId,
      };
}
