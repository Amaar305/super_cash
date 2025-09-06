import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared/shared.dart';

import '../../manage_beneficiary.dart';

part 'manage_beneficiary_state.dart';

class ManageBeneficiaryCubit extends Cubit<ManageBeneficiaryState> {
  ManageBeneficiaryCubit({
    required FetchBeneficiaryUsecase fetchBeneficiaryUsecase,
    required DeleteBeneficiaryUseCase deleteBeneficiaryUseCase,
  })  : _fetchBeneficiaryUsecase = fetchBeneficiaryUsecase,
        _deleteBeneficiaryUseCase = deleteBeneficiaryUseCase,
        super(ManageBeneficiaryState.initial());

  final FetchBeneficiaryUsecase _fetchBeneficiaryUsecase;
  final DeleteBeneficiaryUseCase _deleteBeneficiaryUseCase;

  bool _isFetching = false;
  int _currentPage = 1;
  Future<void> fetchBeneficiaries({
    bool forceReload = false,
  }) async {
    if (isClosed) return;

    if (state.beneficiaries.isNotEmpty && !forceReload) return;

    emit(state.copyWith(
      status: ManageBeneficiaryStatus.loading,
      beneficiaries: [],
      hasReachedMax: false,
      currentPage: 1,
    ));

    final result = await _fetchBeneficiaryUsecase(FetchBeneficiaryParams(
      page: _currentPage,
    ));

    try {
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: ManageBeneficiaryStatus.failure,
            message: failure.message,
          ));
        },
        (response) {
          emit(state.copyWith(
            status: ManageBeneficiaryStatus.success,
            beneficiaries: response.beneficiaries,
            paginationMeta: response.paginationMeta,
            hasReachedMax: response.paginationMeta.next == null,
            nextPageUrl: response.paginationMeta.next,
          ));
        },
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(
        status: ManageBeneficiaryStatus.failure,
        message: 'Failed to load beneficiaries',
      ));
      logE('Error fetching beneficiaries: $error', stackTrace: stackTrace);
    }
  }

  Future<void> deleteBeneficiary(String id) async {
    if (isClosed) return;

    emit(state.copyWith(status: ManageBeneficiaryStatus.loading));

    final result =
        await _deleteBeneficiaryUseCase(DeleteBeneficiaryParams(id: id));

    try {
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: ManageBeneficiaryStatus.failure,
            message: failure.message,
          ));
        },
        (success) {
          emit(state.copyWith(
            status: ManageBeneficiaryStatus.success,
            message: 'Beneficiary deleted successfully',
          ));
          fetchBeneficiaries(forceReload: true);
        },
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(
        status: ManageBeneficiaryStatus.failure,
        message: 'Failed to delete beneficiary',
      ));
      logE('Error deleting beneficiary: $error', stackTrace: stackTrace);
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || state.hasReachedMax || state.nextPageUrl == null) return;

    _isFetching = true;
    _currentPage++;

    emit(state.copyWith(status: ManageBeneficiaryStatus.loading));

    try {
      final res = await _fetchBeneficiaryUsecase(FetchBeneficiaryParams(
        page: _currentPage,
      ));

      res.fold(
        (failure) {
          emit(state.copyWith(
            status: ManageBeneficiaryStatus.failure,
            message: failure.message,
          ));
        },
        (response) {
          final updatedBeneficiaries =
              List<Beneficiary>.from(state.beneficiaries)
                ..addAll(response.beneficiaries);

          emit(state.copyWith(
            status: ManageBeneficiaryStatus.success,
            beneficiaries: updatedBeneficiaries,
            paginationMeta: response.paginationMeta,
            nextPageUrl: response.paginationMeta.next,
            message: 'More beneficiaries loaded successfully',
            hasReachedMax: response.paginationMeta.next == null,
          ));
        },
      );
    } catch (error, stackTrace) {
      emit(state.copyWith(
        status: ManageBeneficiaryStatus.failure,
        message: 'Failed to load more beneficiaries',
      ));
      logE('Error loading more beneficiaries: $error', stackTrace: stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  void refreshTransactions() {
    emit(ManageBeneficiaryState.initial());
    _currentPage = 1;
    _isFetching = false;
    fetchBeneficiaries(forceReload: true);
  }
}
