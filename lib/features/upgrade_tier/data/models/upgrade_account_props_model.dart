// import 'dart:io';

// import 'package:super_cash/features/upgrade_tier/upgrade_tier.dart';

// class UpgradeAccountPropsModel extends UpgradeAccountProps {
//   const UpgradeAccountPropsModel({
//     required super.firstName,
//     required super.lastName,
//     required super.email,
//     required super.phone,
//     required super.country,
//     required super.state,
//     required super.city,
//     required super.houseNumber,
//     required super.houseAddress,
//     required super.postalCode,
//     required super.idType,
//     required super.bvnNumber,
//     super.selfie,
//     required super.selfieFile,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'first_name': firstName,
//       'last_name': lastName,
//       'email_address': email,
//       'phone': phone,
//       'country': country,
//       'state': state,
//       'city': city,
//       'house_no': houseNumber,
//       'address': houseAddress,
//       'postal_code': postalCode,
//       'id_type': '1', //TODO Here
//       'id_no': bvnNumber,
//       'selfie_image': selfie,
//     };
//   }

//   UpgradeAccountPropsModel copyWith({
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phone,
//     String? country,
//     String? state,
//     String? city,
//     String? houseNumber,
//     String? houseAddress,
//     String? postalCode,
//     String? idType,
//     String? bvnNumber,
//     String? selfie,
//     File? selfieFile,
//   }) {
//     return UpgradeAccountPropsModel(
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       city: city ?? this.city,
//       houseNumber: houseNumber ?? this.houseNumber,
//       houseAddress: houseAddress ?? this.houseAddress,
//       postalCode: postalCode ?? this.postalCode,
//       idType: idType ?? this.idType,
//       bvnNumber: bvnNumber ?? this.bvnNumber,
//       selfie: selfie ?? this.selfie,
//       selfieFile: selfieFile ?? this.selfieFile,
//     );
//   }
// }
