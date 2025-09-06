// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

// import 'package:equatable/equatable.dart';

class UpgradeAccountProps {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String state;
  final String city;
  final String houseNumber;
  final String houseAddress;
  final String postalCode;
  final String idType;
  final String bvnNumber;
  final String? selfie;
  final File selfieFile;

  const UpgradeAccountProps({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.houseNumber,
    required this.houseAddress,
    required this.postalCode,
    required this.idType,
    required this.bvnNumber,
     this.selfie,
    required this.selfieFile,
  });

    Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email_address': email,
      'phone': phone,
      'country': country,
      'state': state,
      'city': city,
      'house_no': houseNumber,
      'address': houseAddress,
      'postal_code': postalCode,
      'id_type': '1', //TODO Here
      'id_no': bvnNumber,
      'selfie_image': selfie,
    };
  }

  UpgradeAccountProps copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? country,
    String? state,
    String? city,
    String? houseNumber,
    String? houseAddress,
    String? postalCode,
    String? idType,
    String? bvnNumber,
    String? selfie,
    File? selfieFile,
  }) {
    return UpgradeAccountProps(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      houseNumber: houseNumber ?? this.houseNumber,
      houseAddress: houseAddress ?? this.houseAddress,
      postalCode: postalCode ?? this.postalCode,
      idType: idType ?? this.idType,
      bvnNumber: bvnNumber ?? this.bvnNumber,
      selfie: selfie ?? this.selfie,
      selfieFile: selfieFile ?? this.selfieFile,
    );
  }

  // @override
  // List<Object?> get props => [
  //       firstName,
  //       lastName,
  //       email,
  //       phone,
  //       country,
  //       state,
  //       city,
  //       houseNumber,
  //       houseAddress,
  //       postalCode,
  //       idType,
  //       bvnNumber,
  //       selfie,
  //       selfieFile,
  //     ];

}