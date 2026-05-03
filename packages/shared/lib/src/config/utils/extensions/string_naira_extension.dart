// ignore_for_file: public_member_api_docs

extension StringNairaExtension on num {
  String get planDisplayAmount {
    final am = this;
    if (am < 1000) return am.toStringAsFixed(0);

    final thousands = am / 1000;
    if (thousands == thousands.truncateToDouble()) {
      return '${thousands.toStringAsFixed(0)}k';
    }

    return '${thousands.toStringAsFixed(1)}k';
  }

  double get toGB {
    final value = this;
    if (value < 1) {
      return this / 100;
    }
    return value.toDouble();
  }
}
