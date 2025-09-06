import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChangeCardPinRepositories {
  Future<Either<Failure, Map<String, dynamic>>> changeCardPin({
    required String pin,
    required String cardId,
  });
}
