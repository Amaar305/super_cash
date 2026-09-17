import 'package:equatable/equatable.dart';

/// Result of requerying VTpass for a Smile transaction's latest status.
class SmileTransactionStatus extends Equatable {
  final String status;
  final String message;

  const SmileTransactionStatus({required this.status, required this.message});

  bool get isSuccess => status == 'success';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';

  @override
  List<Object?> get props => [status, message];
}
