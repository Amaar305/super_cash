// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:shared/shared.dart';

class HomeNotification {
  const HomeNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.category,
    required this.startsAt,
    required this.endsAt,
  });

  final String id;
  final String title;
  final String message;
  final String category;
  final DateTime? startsAt;
  final DateTime? endsAt;

  factory HomeNotification.fromJson(Map<String, dynamic> json) =>
      HomeNotification(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        message: json['message'] as String? ?? '',
        category: json['category'] as String? ?? '',
        startsAt: json['starts_at'] == null
            ? null
            : DateTime.parse(json['starts_at'] as String),
        endsAt: json['ends_at'] == null
            ? null
            : DateTime.parse(json['ends_at'] as String),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'category': category,
      'starts_at': startsAt?.toIso8601String(),
      'ends_at': endsAt?.toIso8601String(),
    };
  }
}

class HomeSettings {
  const HomeSettings({
    required this.notification,
    required this.imageSliders,
    required this.appUpdate,
  });

  final HomeNotification? notification;
  final AppUpdate? appUpdate;
  final List<ImageSlider> imageSliders;

  factory HomeSettings.fromJson(Map<String, dynamic> json) => HomeSettings(
        appUpdate: json['app_update'] == null
            ? null
            : AppUpdate.fromJson(json['app_update'] as Map<String, dynamic>),
        imageSliders: json['slider_items'] == null
            ? []
            : List.from(
                (json['slider_items'] as List<dynamic>).map<ImageSlider>(
                  (x) => ImageSlider.fromJson(x as Map<String, dynamic>),
                ),
              ),
        notification: HomeNotification.fromJson(
          json['notice_ticker'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
        'slider_items': imageSliders.map(
          (e) => e.toJson(),
        ),
        'notice_ticker': notification?.toJson(),
      };
}

class AppUpdate {
  const AppUpdate({
    required this.id,
    required this.platform,
    required this.priority,
    required this.minimumVersionName,
    required this.minimumVersionCode,
    required this.latestVersionName,
    required this.latestVersionCode,
    required this.storeUrl,
    required this.changelog,
    required this.metadata,
    required this.requiresUpdate,
    required this.forceUpdate,
  });

  final String id;
  final String platform;
  final int priority;
  final String minimumVersionName;
  final int minimumVersionCode;
  final String latestVersionName;
  final int latestVersionCode;
  final String storeUrl;
  final String changelog;
  final Map<String, dynamic> metadata;
  final bool requiresUpdate;
  final bool forceUpdate;

  factory AppUpdate.fromJson(Map<String, dynamic> json) => AppUpdate(
        id: json['id'] as String? ?? '',
        platform: json['platform'] as String? ?? '',
        priority: (json['priority'] as num?)?.toInt() ?? 0,
        minimumVersionName: json['minimum_version_name'] as String? ?? '',
        minimumVersionCode:
            (json['minimum_version_code'] as num?)?.toInt() ?? 0,
        latestVersionName: json['latest_version_name'] as String? ?? '',
        latestVersionCode: (json['latest_version_code'] as num?)?.toInt() ?? 0,
        storeUrl: json['store_url'] as String? ?? '',
        changelog: json['changelog'] as String? ?? '',
        metadata: (json['metadata'] as Map<String, dynamic>?) ?? const {},
        requiresUpdate: json['requires_update'] as bool? ?? false,
        forceUpdate: json['force_update'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'platform': platform,
        'priority': priority,
        'minimum_version_name': minimumVersionName,
        'minimum_version_code': minimumVersionCode,
        'latest_version_name': latestVersionName,
        'latest_version_code': latestVersionCode,
        'store_url': storeUrl,
        'changelog': changelog,
        'metadata': metadata,
        'requires_update': requiresUpdate,
        'force_update': forceUpdate,
      };
}
