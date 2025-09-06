import 'package:super_cash/core/error/exception.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/domain.dart';
import '../data.dart';

class CreatePinRepositoryImpl implements CreatePinRepository {
  final CreatePinRemoteDataSource createPinRemoteDataSource;

  CreatePinRepositoryImpl({required this.createPinRemoteDataSource});
  @override
  Future<Either<Failure, Map>> createTransactionPin(String pin) async {
    try {
      final response = await createPinRemoteDataSource.createTransactinPin(pin);
      return right(response);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}
