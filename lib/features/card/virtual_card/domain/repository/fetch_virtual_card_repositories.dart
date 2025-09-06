import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract interface class FetchVirtualCardRepositories {
  Future<Either<Failure, List<Card>>> fetchAllVirtualCards();
}
