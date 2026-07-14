import 'kyc_document_data.dart';

class KycDocumentsListResponse {
  final int count;
  final List<KycDocumentData> data;

  const KycDocumentsListResponse({required this.count, required this.data});

  factory KycDocumentsListResponse.fromJson(Map<String, dynamic> json) {
    final rawList = json['data'] as List? ?? [];
    return KycDocumentsListResponse(
      count: int.tryParse(json['count'].toString()) ?? 0,
      data: rawList
          .map((e) => KycDocumentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
