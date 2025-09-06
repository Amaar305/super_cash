import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String accessToken;
  final String refreshToken;
  final bool transactionPin;

  const Token({
    required this.accessToken,
    required this.refreshToken,
    required this.transactionPin,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, transactionPin];
}
