import 'package:equatable/equatable.dart';

class SmilePlan extends Equatable {
  final String id;
  final String variationCode;
  final String name;
  final double variationAmount;
  final double charge;
  final double total;

  const SmilePlan({
    required this.id,
    required this.variationCode,
    required this.name,
    required this.variationAmount,
    required this.charge,
    required this.total,
  });

  @override
  List<Object?> get props => [
    id,
    variationCode,
    name,
    variationAmount,
    charge,
    total,
  ];
}
