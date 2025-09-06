// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared/shared.dart';

class DataPlanDataType {
  const DataPlanDataType({required this.plans, required this.dataTypes});

  const DataPlanDataType.initial() : this(dataTypes: const [], plans: const []);

  final List<DataPlan> plans;
  final List<DataPlanType> dataTypes;

  DataPlanDataType copyWith({
    List<DataPlan>? plans,
    List<DataPlanType>? dataTypes,
  }) {
    return DataPlanDataType(
      plans: plans ?? this.plans,
      dataTypes: dataTypes ?? this.dataTypes,
    );
  }
}
