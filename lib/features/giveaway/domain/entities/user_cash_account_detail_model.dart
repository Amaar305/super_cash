class UserCashAccountDetailModel {
  final String id;
  final String? status;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String? bankCode;
  final String? phoneNumber;

  const UserCashAccountDetailModel({
    required this.id,
    required this.status,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.phoneNumber,
  });

  factory UserCashAccountDetailModel.fromJson(Map<String, dynamic> json) {
    return UserCashAccountDetailModel(
      id: json['id'] as String,
      status: json['status'] as String?,
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
      bankName: json['bank_name'] as String,
      bankCode: json['bank_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }
}
