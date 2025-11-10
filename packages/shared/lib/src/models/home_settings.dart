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
  });

  final HomeNotification? notification;
  final List<ImageSlider> imageSliders;

  factory HomeSettings.fromJson(Map<String, dynamic> json) => HomeSettings(
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
