import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:shared/shared.dart';

class BeneficiaryResponse extends Equatable {
  final List<Beneficiary> beneficiaries;
  final PaginationMeta paginationMeta;

  const BeneficiaryResponse({
    required this.beneficiaries,
    required this.paginationMeta,
  });

  @override
  List<Object?> get props => [beneficiaries, paginationMeta];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'beneficiaries': beneficiaries.map((x) => x.toMap()).toList(),
      'paginationMeta': paginationMeta.toJson(),
    };
  }

  factory BeneficiaryResponse.fromMap(Map<String, dynamic> map) {
    return BeneficiaryResponse(
      beneficiaries: List<Beneficiary>.from(
        (map['results'] as List<dynamic>).map<Beneficiary>(
          (x) => Beneficiary.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paginationMeta: PaginationMeta.fromJson(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory BeneficiaryResponse.fromJson(String source) =>
      BeneficiaryResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Beneficiary extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String network;

  const Beneficiary({
    required this.id,
    required this.name,
    required this.phone,
    required this.network,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'network': network,
    };
  }

  factory Beneficiary.fromMap(Map<String, dynamic> map) {
    return Beneficiary(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      network: map['network'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Beneficiary.fromJson(String source) =>
      Beneficiary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
        name,
        network,
      ];
}
