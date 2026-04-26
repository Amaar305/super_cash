import 'package:super_cash/features/giveaway/giveaway.dart';

class Giveaway {
  final int id;
  final GiveawayType giveawayType;
  final String description;
  final String participantEligibity;
  final String valueToWin;
  final String numberOfUsers;
  final String image;
  final UpcomingGiveawayStatus status;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final bool isActive;
  final DateTime? createdAt;

  const Giveaway({
    required this.id,
    required this.giveawayType,
    required this.description,
    required this.participantEligibity,
    required this.valueToWin,
    required this.numberOfUsers,
    required this.image,
    required this.status,
    required this.startsAt,
    required this.endsAt,
    required this.isActive,
    required this.createdAt,
  });

  /// Safe parsing helpers
  static int _asInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? fallback;
    if (v is num) return v.toInt();
    return fallback;
  }

  static String _asString(dynamic v, {String fallback = ''}) {
    if (v == null) return fallback;
    if (v is String) return v;
    return v.toString();
  }

  static bool _asBool(dynamic v, {bool fallback = false}) {
    if (v is bool) return v;
    if (v is String) {
      final s = v.toLowerCase().trim();
      if (s == 'true' || s == '1' || s == 'yes') return true;
      if (s == 'false' || s == '0' || s == 'no') return false;
    }
    if (v is num) return v != 0;
    return fallback;
  }

  static DateTime? _asDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }

  factory Giveaway.fromJson(Map<String, dynamic>? json) {
    final map = json ?? const <String, dynamic>{};

    return Giveaway(
      id: _asInt(map['id']),
      giveawayType: GiveawayType.fromJson(
        map['giveaway_type'] as Map<String, dynamic>?,
      ),
      description: _asString(map['description']),
      participantEligibity: _asString(map['participant_eligibity']),
      valueToWin: _asString(map['value_to_win']),
      numberOfUsers: _asString(map['number_of_users']),
      image: _asString(map['image']),
      status: UpcomingGiveawayStatus.fromString(_asString(map['status'])),
      startsAt: _asDateTime(map['ends_at']),
      endsAt: _asDateTime(map['starts_at']),
      isActive: _asBool(map['is_active']),
      createdAt: _asDateTime(map['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'giveaway_type': giveawayType.toJson(),
      'description': description,
      'participant_eligibity': participantEligibity,
      'value_to_win': valueToWin,
      'number_of_users': numberOfUsers,
      'image': image,
      'status': status.value,
      'starts_at': startsAt?.toIso8601String(),
      'ends_at': startsAt?.toIso8601String(),
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Giveaway copyWith({
    int? id,
    GiveawayType? giveawayType,
    String? description,
    String? participantEligibity,
    String? valueToWin,
    String? numberOfUsers,
    String? image,
    UpcomingGiveawayStatus? status,
    DateTime? startsAt,
    DateTime? endsAt,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Giveaway(
      id: id ?? this.id,
      giveawayType: giveawayType ?? this.giveawayType,
      description: description ?? this.description,
      participantEligibity: participantEligibity ?? this.participantEligibity,
      valueToWin: valueToWin ?? this.valueToWin,
      numberOfUsers: numberOfUsers ?? this.numberOfUsers,
      image: image ?? this.image,
      status: status ?? this.status,
      startsAt: startsAt ?? this.startsAt,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      endsAt: endsAt ?? this.endsAt,
    );
  }
}

enum UpcomingGiveawayStatus {
  upcoming('upcoming'),
  ongoing('ongoing'),
  completed('completed'),
  cancelled('cancelled');

  final String value;
  const UpcomingGiveawayStatus(this.value);

  bool get isCancelled=> this==UpcomingGiveawayStatus.cancelled;

  bool get isCompleted=> this==UpcomingGiveawayStatus.completed;

  static UpcomingGiveawayStatus fromString(String? value) {
    if (value == null) return UpcomingGiveawayStatus.upcoming;
    switch (value) {
      case 'upcoming':
        return UpcomingGiveawayStatus.upcoming;
      case 'ongoing':
        return UpcomingGiveawayStatus.ongoing;
      case 'completed':
        return UpcomingGiveawayStatus.completed;
      case 'cancelled':
        return UpcomingGiveawayStatus.cancelled;
      default:
        return UpcomingGiveawayStatus.upcoming;
    }
  }
}
