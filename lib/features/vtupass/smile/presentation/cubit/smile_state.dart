// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'smile_cubit.dart';

enum SmileStatus {
  initail,
  loading,
  success,
  failure;

  bool get isError => this == SmileStatus.failure;
  bool get isLoading => this == SmileStatus.loading;
  bool get isSuccess => this == SmileStatus.success;
}

class SmileState extends Equatable {
  final SmileStatus status;
  final String message;
  final Phone phone;
  final bool isPhoneNumber;

  const SmileState._({
    required this.status,
    required this.message,
    required this.phone,
    required this.isPhoneNumber,
  });

  const SmileState.initial()
      : this._(
          status: SmileStatus.initail,
          message: '',
          phone: const Phone.pure(),
          isPhoneNumber: true,
        );

  @override
  List<Object> get props => [
        status,
        message,
        phone,
        isPhoneNumber,
      ];

  SmileState copyWith({
    SmileStatus? status,
    String? message,
    Phone? phone,
    bool? isPhoneNumber,
  }) {
    return SmileState._(
      status: status ?? this.status,
      message: message ?? this.message,
      phone: phone ?? this.phone,
      isPhoneNumber: isPhoneNumber ?? this.isPhoneNumber,
    );
  }
}
