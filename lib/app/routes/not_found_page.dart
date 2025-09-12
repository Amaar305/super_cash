import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cash/app/routes/app_routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Page not found', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.goNamed(RNames.dashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
