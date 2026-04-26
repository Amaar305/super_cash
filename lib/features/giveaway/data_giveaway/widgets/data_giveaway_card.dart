import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

class DataGiveawayCard extends StatelessWidget {
  const DataGiveawayCard({
    required this.dataName,
    required this.dataSize,
    required this.network,
    required this.dataQuantity,
    required this.dataQuantityRemaining,
    required this.isAvailable,
    super.key,
    required this.onClaimed,
  });

  final String dataName;
  final String dataSize;
  final String network;
  final int dataQuantity;
  final int dataQuantityRemaining;
  final bool isAvailable;

  final VoidCallback onClaimed;

  @override
  Widget build(BuildContext context) {
    final accentColor = _networkColor(network);
    final progress = dataQuantity == 0
        ? 0.0
        : dataQuantityRemaining / dataQuantity;
    final slotsLabel = '$dataQuantityRemaining slots available';
    final planSize = _formatDataSize(dataSize);
    final networkLabel = network.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FE),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CardBadge(label: network),
              const Spacer(),
              _StatusPill(isAvailable: isAvailable),
            ],
          ),
          const Gap.v(AppSpacing.lg),
          Text(
            networkLabel,
            style: poppinsTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: accentColor,
            ),
          ),
          const Gap.v(AppSpacing.xs),
          Text(
            planSize,
            style: poppinsTextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF172640),
            ),
          ),
          const Gap.v(AppSpacing.xxs),
          Text(
            dataName,
            style: poppinsTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8F99AA),
            ),
          ),
          const Gap.v(AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: Text(
                  slotsLabel.toUpperCase(),
                  style: poppinsTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
              Text(
                '$dataQuantity TOTAL'.toUpperCase(),
                style: poppinsTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
          const Gap.v(AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFDCE2EE),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF12233D)),
            ),
          ),
          const Gap.v(AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isAvailable ? onClaimed : null,
              style: FilledButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFDCE3F1),
                foregroundColor: const Color(0xFF16233C),
                disabledBackgroundColor: const Color(0xFFE8ECF4),
                disabledForegroundColor: const Color(0xFF98A2B3),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: poppinsTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Claim Data'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDataSize(String size) {
    final parsed = double.tryParse(size);
    if (parsed == null) return size;
    if (parsed >= 1) {
      final value = parsed == parsed.roundToDouble()
          ? parsed.toStringAsFixed(0)
          : parsed.toStringAsFixed(1);
      return '${value}GB';
    }
    final megabytes = (parsed * 1000).round();
    return '${megabytes}MB';
  }

  Color _networkColor(String value) {
    switch (value.toLowerCase()) {
      case 'mtn':
        return const Color(0xFFA57238);
      case 'airtel':
        return const Color(0xFFD45555);
      case 'glo':
        return const Color(0xFF25945A);
      case '9mobilee':
        return const Color(0xFFC34A4A);
      default:
        return const Color(0xFFA57238);
    }
  }
}

class _CardBadge extends StatelessWidget {
  const _CardBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: getNetworkImage(label),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final foreground = isAvailable
        ? const Color(0xFF25945A)
        : const Color(0xFF98A2B3);
    final background = isAvailable
        ? const Color(0xFFEAF7F0)
        : const Color(0xFFF0F2F6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        isAvailable ? 'Available' : 'Unavailable',
        style: poppinsTextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}
