import 'package:fpdart/fpdart.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/smile/domain/domain.dart';

class QuerySmileTransactionStatusUseCase
    implements
        UseCase<SmileTransactionStatus, QuerySmileTransactionStatusParams> {
  final SmileRepository repository;

  const QuerySmileTransactionStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, SmileTransactionStatus>> call(
    QuerySmileTransactionStatusParams param,
  ) {
    return repository.queryTransactionStatus(reference: param.reference);
  }
}

class QuerySmileTransactionStatusParams {
  final String reference;

  const QuerySmileTransactionStatusParams({required this.reference});
}
