import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract class LoginRepository {
  Future<Either<Failure, AppUser>> login(String username, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, AppUser>> fetchUserDetails();
}
