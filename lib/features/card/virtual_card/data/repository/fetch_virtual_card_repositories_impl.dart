import 'package:super_cash/core/error/api_error_handle.dart';
import 'package:super_cash/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/shared.dart';

import '../../virtual_card.dart';

class FetchVirtualCardRepositoriesImpl implements FetchVirtualCardRepositories {
  final FetchVirtualCardRemoteDataSource fetchVirtualCardRemoteDataSource;
  final ApiErrorHandler apiErrorHandle;

 const FetchVirtualCardRepositoriesImpl({
    required this.fetchVirtualCardRemoteDataSource,
    required this.apiErrorHandle,
  });

  @override
  Future<Either<Failure, List<Card>>> fetchAllVirtualCards() async {
    try {
      final response = await fetchVirtualCardRemoteDataSource
          .fetchAllVirtualCards();

      return right(response);
    } catch (e) {
      return left(apiErrorHandle.handleError(e));
    }
  }
}
