import '../../login.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.accessToken,
    required super.refreshToken,
    required super.transactionPin,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access'] ?? '',
      refreshToken: json['refresh'] ?? '',
      transactionPin: json['transactionPin'] ?? false,
    );
  }
}
