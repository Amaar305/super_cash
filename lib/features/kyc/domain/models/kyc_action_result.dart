import 'kyc_status.dart';

class KycActionResult<T> {
  final String message;
  final T data;
  final KycStatus kycStatus;

  const KycActionResult({
    required this.message,
    required this.data,
    required this.kycStatus,
  });
}
