import 'package:flutter/material.dart';

class TransactionDateLabel extends StatelessWidget {
  const TransactionDateLabel(
    this.label, {
    super.key,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: Color.fromRGBO(128, 129, 141, 1)),
    );
  }
}
