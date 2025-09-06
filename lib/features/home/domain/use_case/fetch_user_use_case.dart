import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../domain.dart';

class FetchUserUseCase implements UseCase<AppUser, NoParam> {
  final HomeUserRepository homeUserRepository;

  FetchUserUseCase({required this.homeUserRepository});

  @override
  Future<Either<Failure, AppUser>> call(NoParam param) async {
    return await homeUserRepository.fetchUserDetails();
  }
}
