// ignore_for_file: public_member_api_docs

import 'package:shared/src/models/card.dart';

String _stringFromJson(dynamic value) => value?.toString() ?? '';

/// Response shape for card actions (freeze, unfreeze, delete) that return
/// `{status, message, data: <Card>}`.
class CardActionResponse {
  CardActionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CardActionResponse.fromJson(Map<String, dynamic> json) {
    return CardActionResponse(
      status: _stringFromJson(json['status']),
      message: _stringFromJson(json['message']),
      data: Card.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
  final String status;
  final String message;
  final Card data;

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };
}
