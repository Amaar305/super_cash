

class ReferralTypeModel {
  final String id;
  final int? maxReferees;
  final int conversionWindowDays;
  final String perRefereeReward;
  final String name;
  final ReferralTypeModelStatus status;
  final String description;

  const ReferralTypeModel({
    this.id = '',
    this.conversionWindowDays = 7,
    this.status = ReferralTypeModelStatus.active,
    required this.maxReferees,
    required this.perRefereeReward,
    required this.name,
    required this.description,
  });

  String get maxRefereesString =>
      maxReferees != null ? '$maxReferees' : 'Unlimited';

  bool get hasLimitedReferees => maxReferees != null;

  factory ReferralTypeModel.fromJson(Map<String, dynamic> json) {
    return ReferralTypeModel(
      id: json['id'] as String? ?? '',
      maxReferees: (json['max_referees'] as num?)?.toInt(),
      conversionWindowDays:
          (json['conversion_window_days'] as num?)?.toInt() ?? 7,
      perRefereeReward: json['per_referee_reward'] as String? ?? '',
      name: json['name'] as String? ?? '',
      status: ReferralTypeModel._statusFromJson(json['status'] as String?),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'max_referees': maxReferees,
      'conversion_window_days': conversionWindowDays,
      'per_referee_reward': perRefereeReward,
      'name': name,
      'status': status.name,
      'description': description,
    };
  }

  static ReferralTypeModelStatus _statusFromJson(String? status) {
    if (status == null) {
      return ReferralTypeModelStatus.ended;
    }

    final normalizedStatus = status.toLowerCase();
    return ReferralTypeModelStatus.values.firstWhere(
      (value) => value.name == normalizedStatus,
      orElse: () => ReferralTypeModelStatus.active,
    );
  }
}

enum ReferralTypeModelStatus {
  active,
  paused,
  ended;

  bool get isActive => this == ReferralTypeModelStatus.active;

  bool get isPaused => this == ReferralTypeModelStatus.paused;
  bool get isEnded => this == ReferralTypeModelStatus.ended;
}
