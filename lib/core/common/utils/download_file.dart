import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

// Platform-specific implementation
Future<void> saveToDownloads(
  ByteData byteData,
  String fileName,
  BuildContext context,
) async {
  try {
    final bytes = byteData.buffer.asUint8List();

    if (Platform.isAndroid) {
      // Request proper storage access before writing to the Downloads folder
      var permissionStatus = await Permission.manageExternalStorage.request();
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.storage.request();
      }

      if (!permissionStatus.isGranted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Storage permission is required to save the receipt. Please enable it in Settings.',
              ),
            ),
          );
        }
        return;
      }

      final dir = await getExternalStorageDirectory();
      if (dir != null) {
        final downloadsDir = Directory('${dir.path}/Download');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }

        final file = File('${downloadsDir.path}/$fileName');
        await file.writeAsBytes(bytes);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Receipt saved to Downloads/$fileName')),
          );
        }
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
