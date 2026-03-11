part of 'airtime_giveaway_cubit.dart';

enum AirtimeGiveawayStatus {
  initial,
  loading,
  loaded,
  processing,
  processed,
processingError,
  failure;

  bool get isInitial => this == AirtimeGiveawayStatus.initial;
  bool get isLoading => this == AirtimeGiveawayStatus.loading;
  bool get isSuccess => this == AirtimeGiveawayStatus.loaded;
  bool get isFailure => this == AirtimeGiveawayStatus.failure;
  bool get isProcessing => this == AirtimeGiveawayStatus.processing;
  bool get isProcressed => this == AirtimeGiveawayStatus.processed;
  bool get isProcressingError => this == AirtimeGiveawayStatus.processingError;
}

class AirtimeGiveawayState extends Equatable {
  final AirtimeGiveawayStatus status;
  final List<AirtimeGiveawayPin> giveawayPins;
  final String? errorMessage;
  final AirtimeGiveawayPin? claimedPin;


  const AirtimeGiveawayState._({
    required this.status,
    required this.giveawayPins,
    this.errorMessage,
    this.claimedPin,
  });

  const AirtimeGiveawayState.initial()
    : this._(
        status: AirtimeGiveawayStatus.initial,
        giveawayPins: const [],
        errorMessage: '',
      );

  @override
  List<Object?> get props => [status, giveawayPins, errorMessage, claimedPin];

  AirtimeGiveawayState copyWith({
    AirtimeGiveawayStatus? status,
    List<AirtimeGiveawayPin>? giveawayPins,
    String? errorMessage,
    AirtimeGiveawayPin? claimedPin,
  }) {
    return AirtimeGiveawayState._(
      status: status ?? this.status,
      giveawayPins: giveawayPins ?? this.giveawayPins,
      errorMessage: errorMessage ?? this.errorMessage,
      claimedPin: claimedPin ?? this.claimedPin,
    );
  }

  @override
  String toString() =>
      'AirtimeGiveawayState(status: $status, giveawayPins: $giveawayPins, errorMessage: $errorMessage, claimedPin: $claimedPin)';
}
