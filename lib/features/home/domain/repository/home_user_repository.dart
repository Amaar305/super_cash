import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

abstract class HomeUserRepository {
  Future<Either<Failure, AppUser>> fetchUserDetails();
}
