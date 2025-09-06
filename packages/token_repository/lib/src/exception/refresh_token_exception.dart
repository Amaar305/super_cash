///
class RefreshTokenException implements Exception {
  ///
  const RefreshTokenException(this.message);

  ///
  final String message;

  @override
  String toString() => message;
}
