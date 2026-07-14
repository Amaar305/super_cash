import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/kyc/kyc.dart';

part 'kyc_government_id_state.dart';

class KycGovernmentIdCubit extends Cubit<KycGovernmentIdState> {
  final GetDocumentsUseCase _getDocumentsUseCase;
  final UploadDocumentUseCase _uploadDocumentsUseCase;

  KycGovernmentIdCubit({
    required GetDocumentsUseCase getDocumentsUseCase,
    required UploadDocumentUseCase uploadDocumentsUseCase,
  })  : _getDocumentsUseCase = getDocumentsUseCase,
        _uploadDocumentsUseCase = uploadDocumentsUseCase,
        super(const KycGovernmentIdState.initial());

  Future<void> getDocuments() async {
    emit(state.copyWith(status: KycGovernmentIdStatus.loading));
    final result = await _getDocumentsUseCase(NoParam());
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(
        status: KycGovernmentIdStatus.failure,
        message: failure.message,
      )),
      (success) {
        final existing = success.data.isNotEmpty ? success.data.first : null;
        emit(state.copyWith(
          status: KycGovernmentIdStatus.success,
          documentsListResponse: success,
          selectedDocumentType: existing?.documentType,
          documentNumber: existing?.documentNumber ?? '',
        ));
      },
    );
  }

  void onDocumentTypeSelected(String? type) {
    emit(state.copyWith(
      selectedDocumentType: type,
      clearSelectedDocumentTypeError: true,
    ));
  }

  void onDocumentNumberChanged(String value) {
    emit(state.copyWith(
      documentNumber: value,
      clearDocumentNumberError: true,
    ));
  }

  void onDocumentImageSelected(File? file) {
    if (file == null) return;
    emit(state.copyWith(
      documentImageFile: file,
      clearDocumentImageError: true,
    ));
  }

  Future<void> uploadDocument() async {
    final type = state.selectedDocumentType;
    final number = state.documentNumber.trim();
    final file = state.documentImageFile;

    bool hasError = false;

    if (type == null || type.isEmpty) {
      emit(state.copyWith(
          selectedDocumentTypeError: 'Please select a document type.'));
      hasError = true;
    }
    if (number.isEmpty) {
      emit(state.copyWith(documentNumberError: 'Document number is required.'));
      hasError = true;
    }
    if (file == null && !state.alreadySubmitted) {
      emit(state.copyWith(documentImageError: 'Please provide a document image.'));
      hasError = true;
    }

    if (hasError) return;

    emit(state.copyWith(
      status: KycGovernmentIdStatus.uploading,
      clearSelectedDocumentTypeError: true,
      clearDocumentNumberError: true,
      clearDocumentImageError: true,
    ));

    try {
      final uploadFile =
          file != null ? (await _compress(file) ?? file) : File('');
      final result = await _uploadDocumentsUseCase(KycDocumentParams(
        documentType: type!,
        documentNumber: number,
        image: uploadFile,
      ));
      if (isClosed) return;

      result.fold(
        (failure) => emit(state.copyWith(
          status: KycGovernmentIdStatus.failure,
          message: failure.message,
        )),
        (success) => emit(state.copyWith(
          status: KycGovernmentIdStatus.uploaded,
          message: success.message,
        )),
      );
    } catch (error, stackTrace) {
      logE('Failed to upload document: $error', stackTrace: stackTrace);
      emit(state.copyWith(
        status: KycGovernmentIdStatus.failure,
        message: 'Upload failed. Please try again.',
      ));
    }
  }

  Future<File?> _compress(File file) async {
    const maxBytes = 800 * 1024;
    if (await file.length() <= maxBytes) return null;
    final dir = await getTemporaryDirectory();
    final target =
        '${dir.path}${Platform.pathSeparator}doc_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      target,
      quality: 80,
      minWidth: 1280,
      minHeight: 1280,
      format: CompressFormat.jpeg,
    );
    return result != null ? File(result.path) : null;
  }
}
