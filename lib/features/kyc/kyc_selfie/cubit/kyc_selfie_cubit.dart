import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_selfie_state.dart';

class KycSelfieCubit extends Cubit<KycSelfieState> {
  final UploadSelfieUseCase _uploadSelfieUseCase;
  final GetSelfieUseCase _getSelfieUseCase;

  KycSelfieCubit({
    required UploadSelfieUseCase uploadSelfieUseCase,
    required GetSelfieUseCase getSelfieUseCase,
  })  : _uploadSelfieUseCase = uploadSelfieUseCase,
        _getSelfieUseCase = getSelfieUseCase,
        super(const KycSelfieState.initial());

  Future<void> getSelfie() async {
    emit(state.copyWith(status: KycSelfieStatus.loading));
    final result = await _getSelfieUseCase(NoParam());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: KycSelfieStatus.failure,
        message: failure.message,
      )),
      (success) => emit(state.copyWith(
        status: KycSelfieStatus.success,
        selfieResponse: success,
      )),
    );
  }

  void onSelfieSelected(File? file) {
    if (file == null) return;
    emit(state.copyWith(
      selfieFile: file,
      clearSelfieError: true,
    ));
  }

  Future<void> submitSelfie() async {
    final file = state.selfieFile;
    if (file == null) {
      emit(state.copyWith(selfieError: 'Please take or select a selfie.'));
      return;
    }

    emit(state.copyWith(
      status: KycSelfieStatus.uploading,
      clearSelfieError: true,
    ));

    try {
      final uploadFile = await _compress(file) ?? file;
      final result = await _uploadSelfieUseCase(uploadFile);
      if (isClosed) return;

      result.fold(
        (failure) => emit(state.copyWith(
          status: KycSelfieStatus.failure,
          message: failure.message,
        )),
        (success) => emit(state.copyWith(
          status: KycSelfieStatus.uploaded,
          message: success.message,
        )),
      );
    } catch (error, stackTrace) {
      logE('Failed to upload selfie $error', stackTrace: stackTrace);
      emit(state.copyWith(
        status: KycSelfieStatus.failure,
        message: 'Upload failed. Please try again.',
      ));
    }
  }

  Future<File?> _compress(File file) async {
    const maxBytes = 600 * 1024;
    if (await file.length() <= maxBytes) return null;
    final dir = await getTemporaryDirectory();
    final target =
        '${dir.path}${Platform.pathSeparator}selfie_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      target,
      quality: 75,
      minWidth: 1280,
      minHeight: 1280,
      format: CompressFormat.jpeg,
    );
    return result != null ? File(result.path) : null;
  }
}
