// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_pin_cubit.dart';

enum CreatePinStatus {
  initial,
  loading,
  success,
  failure;

  bool get isSuccess => this == CreatePinStatus.success;
  bool get isLoading => this == CreatePinStatus.loading;
  bool get isError => this == CreatePinStatus.failure;
}

class CreatePinState extends Equatable {
  const CreatePinState._({
    required this.confirmPin,
    required this.message,
    required this.newPin,
    required this.status,
    required this.confirmPinMessage,
    required this.newPinMessage,
    required this.showPin,
    required this.response,
  });

  const CreatePinState.inital()
      : this._(
            confirmPin: const Otp.pure(),
            message: '',
            newPin: const Otp.pure(),
            status: CreatePinStatus.initial,
            confirmPinMessage: '',
            showPin: false,
            newPinMessage: '',
            response: null);
  final CreatePinStatus status;
  final Otp newPin;
  final Otp confirmPin;
  final String message;
  final String newPinMessage;
  final String confirmPinMessage;
  final bool showPin;
  final Map? response;
  @override
  List<Object?> get props => [
        status,
        newPin,
        confirmPin,
        message,
        newPinMessage,
        confirmPinMessage,
        showPin,
        response,
      ];

  CreatePinState copyWith({
    CreatePinStatus? status,
    Otp? newPin,
    Otp? confirmPin,
    String? message,
    String? newPinMessage,
    String? confirmPinMessage,
    bool? showPin,
    Map? response,
  }) {
    return CreatePinState._(
      status: status ?? this.status,
      newPin: newPin ?? this.newPin,
      confirmPin: confirmPin ?? this.confirmPin,
      message: message ?? this.message,
      newPinMessage: newPinMessage ?? this.newPinMessage,
      confirmPinMessage: confirmPinMessage ?? this.confirmPinMessage,
      showPin: showPin ?? this.showPin,
      response: response ?? this.response,
    );
  }
}
