import 'dart:io';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';

// Platform-specific implementation
Future<void> saveToDownloads(
  ByteData byteData,
  String fileName,
  BuildContext context,
) async {
  try {
    final bytes = byteData.buffer.asUint8List();

    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();

      final file = File(
        '${directory.path}/attendance_qr_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes);

      await Gal.putImage(file.path);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('QR saved to ${file.path}'),
            backgroundColor: AppColors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else if (Platform.isIOS) {
      // For iOS, use share sheet or save to photo library
      final dir = await getTemporaryDirectory();
      final tempFile = File('${dir.path}/$fileName');
      await tempFile.writeAsBytes(bytes);

      if (!context.mounted) return;

      // Use share sheet for user to choose location
      await Share.shareXFiles(
        [XFile(tempFile.path)],
        sharePositionOrigin: Rect.fromCenter(
          center: MediaQuery.of(context).size.center(Offset.zero),
          width: 300,
          height: 300,
        ),
      );

      // Clean up temp file after sharing
      await Future.delayed(const Duration(seconds: 5));
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  } catch (e) {
    rethrow;
  }
}
