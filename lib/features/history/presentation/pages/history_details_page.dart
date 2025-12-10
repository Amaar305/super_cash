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
import 'package:super_cash/core/app_strings/app_string.dart';
import 'package:super_cash/core/common/utils/download_file.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
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

class HistoryReportButton extends StatelessWidget {
  const HistoryReportButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(label: 'Report', onPressed: onPressed);
  }
}

class HistoryActionButtons extends StatelessWidget {
  const HistoryActionButtons({
    super.key,
    required this.onDownload,
    required this.onShare,
  });

  final VoidCallback onDownload;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: OutlineHistoryActionButton(
            title: 'Download',
            onPressed: onDownload,
          ),
        ),
        Expanded(
          child: OutlineHistoryActionButton(title: 'Share', onPressed: onShare),
        ),
      ],
    );
  }
}

class OutlineHistoryActionButton extends StatelessWidget {
  const OutlineHistoryActionButton({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppButton.outlined(
      text: title,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        fixedSize: Size.fromHeight(50),
      ),
    );
  }
}

class HistoryTransactionStatusDetail extends StatelessWidget {
  const HistoryTransactionStatusDetail({super.key, required this.transaction});
  final TransactionResponse transaction;

  Color? get transactionColor {
    if (transaction.transactionStatus.isFailed) {
      return AppColors.red;
    }
    if (transaction.transactionStatus.isSuccess) {
      return AppColors.green;
    }
    if (transaction.transactionStatus.isPending) {
      return AppColors.orange;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          margin: EdgeInsets.symmetric(horizontal: 57),
          decoration: BoxDecoration(
            color: transactionColor?.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.sm,
            children: [
              Icon(
                Icons.verified,
                size: AppSize.iconSizeSmall,
                color: transactionColor,
              ),
              FittedBox(
                child: Text(
                  transaction.transactionStatus.isFailed
                      ? 'Transaction failed'
                      : transaction.transactionStatus.isPending
                      ? 'Transaction pending'
                      : transaction.transactionStatus.isRefund
                      ? 'Transaction Refund'
                      : 'Transaction successfully',
                  style: poppinsTextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Gap.v(AppSpacing.sm),
        Text(
          transaction.formattedAmount,
          style: poppinsTextStyle(
            fontSize: context.titleLarge?.fontSize,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        Gap.v(AppSpacing.xs),
        Text(
          'Transaction amount',
          style: poppinsTextStyle(fontSize: 10, color: AppColors.hinTextColor),
        ),
      ],
    );
  }
}

class HistoryDetailHeader extends StatelessWidget {
  const HistoryDetailHeader({super.key, required this.transaction});

  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            Assets.images.logo.image(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: poppinsTextStyle(
                    fontSize: context.titleMedium?.fontSize,
                  ),
                ),
                Text(
                  'A Product of Cool Data',
                  style: poppinsTextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Receipt',
              style: poppinsTextStyle(
                fontWeight: AppFontWeight.semiBold,
                fontSize: AppSpacing.md,
              ),
            ),
            Row(
              children: [
                Text(
                  formatDateTime(
                    transaction.createdAt,
                  ).split(',').take(2).join(),
                  style: poppinsTextStyle(fontSize: 10),
                ),
                Text(
                  formatDateTime(transaction.createdAt).split(',').last,
                  style: poppinsTextStyle(
                    fontSize: 10,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key, required this.transaction});
  final TransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.xlg),
      alignment: Alignment(0, 0),
      child: Column(
        children: [
          HistoryDetailTile(
            label: 'Transaction ID',
            trailingLabel: transaction.reference,
          ),
          HistoryDetailTile(
            label: 'Type',
            trailingLabel: transaction.transactionType.name.capitalize,
          ),
          HistoryDetailTile(
            label: 'Amount',
            trailingLabel: transaction.formattedAmount,
          ),
          HistoryDetailTile(
            label: 'Date',
            trailingLabel: formatDateTime(
              transaction.createdAt,
            ).split(',').take(2).join(),
          ),
          HistoryDetailTile(
            label: 'Time',
            trailingLabel: formatDateTime(
              transaction.createdAt,
            ).split(',').last,
          ),
          HistoryDetailTile(
            label: 'Description',
            trailingLabel: transaction.description,
          ),
          HistoryDetailTile(
            label: 'Status',
            trailingLabel: transaction.transactionStatus.name.capitalize,
          ),
        ],
      ),
    );
  }
}

class HistoryDetailTile extends StatelessWidget {
  const HistoryDetailTile({
    super.key,
    required this.label,
    required this.trailingLabel,
  });

  final String label;
  final String trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        spacing: AppSpacing.xs,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: poppinsTextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 12,
                ),
              ),
              Flexible(
                child: Text(
                  trailingLabel,
                  textAlign: TextAlign.end,
                  style: poppinsTextStyle(
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            // thickness: 0.7,
            color: Color.fromRGBO(237, 238, 242, 0.9),
          ),
        ],
      ),
    );
  }
}
