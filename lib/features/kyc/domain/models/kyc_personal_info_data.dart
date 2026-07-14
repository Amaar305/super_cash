class KycPersonalInfoData {
  final String firstName;
  final String lastName;
  final String middleName;
  final String? dateOfBirth;
  final String? gender;
  final bool isVerified;
  final String? updatedAt;

  const KycPersonalInfoData({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.dateOfBirth,
    this.gender,
    this.isVerified = false,
    this.updatedAt,
  });

  factory KycPersonalInfoData.fromJson(Map<String, dynamic> json) {
    return KycPersonalInfoData(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      middleName: json['middle_name'] as String? ?? '',
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
        if (gender != null) 'gender': gender,
      };
}
