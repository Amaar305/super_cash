import 'package:equatable/equatable.dart';

/// One of the phone/device accounts linked to a verified Smile email
/// (the `AccountId`/`FriendlyName` pairs VTpass returns from `AccountList`).
class SmileAccount extends Equatable {
  final String accountId;
  final String friendlyName;

  const SmileAccount({required this.accountId, required this.friendlyName});

  @override
  List<Object?> get props => [accountId, friendlyName];
}
