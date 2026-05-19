import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/home/home.dart';

class CreatePalmPayAccountUseCase
    implements
        UseCase<({String message, String status, Account? account}), NoParam> {
  final HomeUserRepository repository;

  CreatePalmPayAccountUseCase(this.repository);

  @override
  Future<Either<Failure, ({Account? account, String message, String status})>>
  call(NoParam param) async {
    return await repository.createPalmPayAccount();
  }
}
