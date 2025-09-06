// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.read,
    required this.data,
    required this.status,
  });

  factory Notification.fromJson(Map<String, dynamic> map) =>
      _$NotificationFromJson(map);
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final bool read;
  final Map<String, dynamic> data;
  final String status;

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? read,
    Map<String, dynamic>? data,
    String? status,
  }) {
    return Notification(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      read: read ?? this.read,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}
