import '../../domain/domain.dart';

class ConfirmPinModel extends ConfirmPin {
  ConfirmPinModel({
    required super.messsage,
    required super.status,
    required super.verified,
  });

  factory ConfirmPinModel.fromJson(Map<String, dynamic> json) {
    return ConfirmPinModel(
      messsage: json['message'] as String,
      status: json['status'] as String,
      verified: json['verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': messsage,
      'status': status,
      'verified': verified,
    };
  }
}
