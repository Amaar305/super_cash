class UserDirectAirtimePhoneModel {
  final String id;
  final String phoneNumber;
  final String airtimeStatus;
  final String network;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String airtimeId;

  const UserDirectAirtimePhoneModel({
    required this.id,
    required this.phoneNumber,
    required this.airtimeStatus,
    required this.network,
    required this.createdAt,
    required this.updatedAt,
    required this.airtimeId,
  });

  factory UserDirectAirtimePhoneModel.fromJson(Map<String, dynamic> json) {
    return UserDirectAirtimePhoneModel(
      id: json['id'],
      phoneNumber: json['phone_number'],
      airtimeStatus: json['airtime_status'],
      network: json['network'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      airtimeId: json['airtime_id'],
    );
  }
}
