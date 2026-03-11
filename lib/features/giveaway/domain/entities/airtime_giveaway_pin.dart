class AirtimeGiveawayPin {
  final String id;
  final String network;
  final double amount;
  final String maskedPin;
  final String? loadingCode;
  final String status;

  bool get isUsed =>
      status.toLowerCase() == 'claimed' || status.toLowerCase() == 'claim';

  factory AirtimeGiveawayPin.fromJson(Map<String, dynamic> json) {
    return AirtimeGiveawayPin(
      id: json['id'],
      network: json['network'],
      amount: json['amount'].toDouble(),
      maskedPin: json['pin'],
      status: json['status'],
      loadingCode: json['loading_code'] as String?,
    );
  }

  AirtimeGiveawayPin({
    required this.id,
    required this.network,
    required this.amount,
    required this.maskedPin,
    required this.status,
    this.loadingCode,
  });

  Map<String, dynamic> fromJson() => {
    "id": id,
    "network": network,
    "amount": amount,
    "pin": maskedPin,
    "status": status,
    "loading_code": loadingCode,
  };
}
