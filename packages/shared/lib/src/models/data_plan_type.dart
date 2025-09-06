// ignore_for_file: public_member_api_docs, sort_constructors_first
class DataPlanType {
  DataPlanType({
    required this.dataType,
    required this.dataStatus,
  });

  factory DataPlanType.fromJson(Map<String, dynamic> json) {
    return DataPlanType(
      dataType: json['DataType'] as String,
      dataStatus: json['DataStatus'] as bool,
    );
  }
  final String dataType;
  final bool dataStatus;

  DataPlanType copyWith({
    String? dataType,
    bool? dataStatus,
  }) {
    return DataPlanType(
      dataType: dataType ?? this.dataType,
      dataStatus: dataStatus ?? this.dataStatus,
    );
  }
}
