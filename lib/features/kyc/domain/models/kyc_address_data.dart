class KycAddressData {
  final String country;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String houseNo;
  final String lga;

  const KycAddressData({
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    this.postalCode = '',
    this.houseNo = '',
    this.lga = '',
  });

  factory KycAddressData.fromJson(Map<String, dynamic> json) {
    return KycAddressData(
      country: json['country'] as String? ?? 'Nigeria',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      postalCode: json['postal_code'] as String? ?? '',
      houseNo: json['house_no'] as String? ?? '',
      lga: json['lga'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'country': country,
        'address': address,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'house_no': houseNo,
        'lga': lga,
      };
}
