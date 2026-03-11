import 'package:flutter/material.dart';

class GiveawayWinnersFailure extends StatelessWidget {
  const GiveawayWinnersFailure({super.key, this.message, this.onTap});
  final String? message;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message ?? 'Something went wrong!'),
          ElevatedButton(onPressed: onTap, child: const Text('Retry')),
        ],
      ),
    );
  }
}
