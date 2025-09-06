// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionResponse {
  TransactionResponse({
    required this.description,
    required this.transactionType,
    required this.transactionStatus,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.reference,
    required this.createdAt,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
  final String description;
  @JsonKey(name: 'transaction_type', defaultValue: TransactionType.others)
  final TransactionType transactionType;
  @JsonKey(name: 'transaction_status', defaultValue: TransactionStatus.pending)
  final TransactionStatus transactionStatus;
  final String amount;
  @JsonKey(name: 'balance_before')
  final String balanceBefore;
  @JsonKey(name: 'balance_after')
  final String balanceAfter;
  final String reference;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);

  String get formattedAmount => 'N$amount';
}

enum TransactionType {
  data('data'),
  card('card'),
  cardholder('cardholder'),
  credit('credit'),
  debit('debit'),
  cardfunding('cardfunding'),
  cable('cable'),
  electricity('electricity'),
  walletfunding('walletfunding'),
  airtime('airtime'),
  palmpay('palmpay'),
  others('others');

  const TransactionType(this.value);
  final String value;

  bool get isData => this == TransactionType.data;
  bool get isAirtime => this == TransactionType.airtime;
  bool get isCable => this == TransactionType.cable;
  bool get isElectricity => this == TransactionType.electricity;
  bool get isCard => this == TransactionType.card;
  bool get isCardFunding => this == TransactionType.cardfunding;
  bool get isWalletfunding => this == TransactionType.walletfunding;
  bool get isCardholder => this == TransactionType.cardholder;
  bool get isPalmpay => this == TransactionType.palmpay;
}

enum TransactionStatus {
  pending('pending'),
  success('success'),
  successful('successful'),
  failed('failed'),
  fail('fail'),
  refund('refund'),
  reversal('reversal'),
  processing('processing');

  const TransactionStatus(this.value);

  final String value;

  bool get isFailed =>
      this == TransactionStatus.fail || this == TransactionStatus.failed;
  bool get isPending =>
      this == TransactionStatus.pending || this == TransactionStatus.processing;
  bool get isSuccess =>
      this == TransactionStatus.success || this == TransactionStatus.successful;
  bool get isReverse =>
      this == TransactionStatus.reversal || this == TransactionStatus.reversal;
  bool get isRefund => this == TransactionStatus.refund;
}
