class KycBvnStep {
  final bool complete;
  final String note;
  final String? bvn;

  const KycBvnStep({
    required this.complete,
    this.note = '',
    this.bvn,
  });

  factory KycBvnStep.fromJson(Map<String, dynamic> json) {
    return KycBvnStep(
      complete: json['complete'] as bool? ?? false,
      note: json['note'] as String? ?? '',
      bvn: json['bvn'] as String?,
    );
  }
}
