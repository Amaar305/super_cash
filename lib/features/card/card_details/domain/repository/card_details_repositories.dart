import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class CardDetailsRepositories {
  Future<Either<Failure, CardDetails>> getFullCardDetails(String cardId);

  Future<Either<Failure, Map<String, dynamic>>> freezeCard(String cardId);
}
