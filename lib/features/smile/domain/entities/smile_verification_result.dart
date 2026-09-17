import 'package:equatable/equatable.dart';

import 'smile_account.dart';

class SmileVerificationResult extends Equatable {
  final String? customerName;
  final List<SmileAccount> accounts;

  const SmileVerificationResult({this.customerName, required this.accounts});

  @override
  List<Object?> get props => [customerName, accounts];
}
