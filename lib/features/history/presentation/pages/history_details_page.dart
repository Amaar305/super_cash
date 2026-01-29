import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/common/utils/download_file.dart';
import 'package:super_cash/features/history/presentation/widgets/history_action_buttons.dart';
import 'package:super_cash/features/history/presentation/widgets/history_detail_header.dart';
import 'package:super_cash/features/history/presentation/widgets/history_report_button.dart';
import 'package:super_cash/features/history/presentation/widgets/history_transaction_status_detail.dart';
import 'package:super_cash/features/history/presentation/widgets/transaction_details.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryDetailsPage extends StatelessWidget {
  HistoryDetailsPage({super.key, required this.transaction})
    : _receiptKey = GlobalKey();

  final TransactionResponse transaction;
  final GlobalKey _receiptKey;

  Future<void> _downloadReceipt(BuildContext context) async {
    try {
      final file = await _compileReceiptToFile();
      if (file == null) return;
      final filePath = file.path;
      final byteData = await File(filePath).readAsBytes();
      final bytes = ByteData.view(byteData.buffer);

      if (!context.mounted) return;

      await saveToDownloads(
        bytes,
        'receipt_${transaction.reference}.png',
        context,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download receipt')),
        );
      }
    }
  }

  Future<File?> _compileReceiptToFile() async {
    final boundary =
        _receiptKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final ui.Image image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;

    final directory = await getTemporaryDirectory();
    final sanitizedReference = transaction.reference.replaceAll(
      RegExp(r'[^a-zA-Z0-9]'),
      '_',
    );
    final filePath = '${directory.path}/receipt_$sanitizedReference.png';
    final file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  Future<void> _shareReceipt(BuildContext context) async {
    try {
      final file = await _compileReceiptToFile();
      if (file == null) return;

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Receipt ${transaction.reference}');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to share receipt')),
        );
      }
    }
  }

  Future<void> _reportReceipt(BuildContext context) async {
    try {
      final file = await _compileReceiptToFile();
      if (file == null) return;

      final encodedMessage = Uri.encodeComponent(
        'Hello, I would like to report a receipt for transaction '
        '${transaction.reference}.',
      );
      final uri = Uri.parse('https://wa.me/2347075179929?text=$encodedMessage');

      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open WhatsApp')),
          );
        }
        return;
      }

      await Share.shareXFiles([
        XFile(file.path, mimeType: 'image/png'),
      ], text: 'Receipt ${transaction.reference}');
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to report receipt')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Transaction Details'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: RepaintBoundary(
        key: _receiptKey,
        child: ColoredBox(
          color: Colors.white,
          child: AppConstrainedScrollView(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                HistoryDetailHeader(transaction: transaction),
                Gap.v(AppSpacing.xlg),
                HistoryTransactionStatusDetail(transaction: transaction),
                Gap.v(AppSpacing.xlg),
                TransactionDetails(transaction: transaction),
                HistoryActionButtons(
                  onDownload: () => _downloadReceipt(context),
                  onShare: () => _shareReceipt(context),
                ),
                Gap.v(AppSpacing.lg),
                HistoryReportButton(onPressed: () => _reportReceipt(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
