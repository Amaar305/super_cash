// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'virtual_card_cubit.dart';

enum VirtualCardStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == VirtualCardStatus.failure;
  bool get isLaoding => this == VirtualCardStatus.loading;
  bool get isSuccess => this == VirtualCardStatus.success;
}

class VirtualCardState extends Equatable {
  const VirtualCardState({
    required this.status,
    required this.cards,
    required this.message,
  });

  final VirtualCardStatus status;
  final List<Card> cards;
  final String message;

  @override
  List<Object> get props => [
        status,
        cards,
        message,
      ];

  VirtualCardState copyWith({
    VirtualCardStatus? status,
    List<Card>? cards,
    String? message,
  }) {
    return VirtualCardState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      message: message ?? this.message,
    );
  }
}
