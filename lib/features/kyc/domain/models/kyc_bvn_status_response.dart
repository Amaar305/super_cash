class KycBvnStatusResponse {
  final bool complete;
  final String? bvn;

  const KycBvnStatusResponse({required this.complete, this.bvn});

  factory KycBvnStatusResponse.fromJson(Map<String, dynamic> json) {
    return KycBvnStatusResponse(
      complete: json['complete'] as bool? ?? false,
      bvn: json['bvn'] as String?,
    );
  }
}
