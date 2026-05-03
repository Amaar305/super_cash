import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/core/helper/app_url_launcher.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';
import 'package:super_cash/features/vtupass/vtupass.dart';

final _primaryColor = AppColors.blue;

////
class GiveawayCard extends StatelessWidget {
  const GiveawayCard({super.key, required this.giveawayHistory});
  final GiveawayHistory giveawayHistory;

  @override
  Widget build(BuildContext context) {
    
    if (giveawayHistory.isProductGiveaway) {
      return _ProductHistoryCard(giveawayHistory: giveawayHistory);
    }
    if (giveawayHistory.isCashGiveaway) {
      return _CashHistoryCard(giveawayHistory: giveawayHistory);
    }
    return _DataHistoryCard(giveawayHistory: giveawayHistory);
  }
}

class _ProductHistoryCard extends StatelessWidget {
  const _ProductHistoryCard({required this.giveawayHistory});

  final GiveawayHistory giveawayHistory;

  @override
  Widget build(BuildContext context) {
    final product = giveawayHistory.productGiveaway;
    final title = product.productName.isEmpty
        ? 'Product giveaway'
        : product.productName;
    final description = product.productDescription.isEmpty
        ? giveawayHistory.description
        : product.productDescription;

    return _HistoryCardShell(
      accentColor: const Color(0xFF7C3AED),
      backgroundColor: const Color(0xFFFFFBF0),
      icon: Icons.shopping_bag_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductImage(image: product.image),
              Gap.h(AppSpacing.md),
              Expanded(
                child: _HistoryTitleBlock(
                  eyebrow: 'Product claimed',
                  title: title,
                  subtitle: description,
                  date: giveawayHistory.createdAt,
                ),
              ),
              _ClaimedBadge(),
            ],
          ),
          if (product.productSpecification.isNotEmpty) ...[
            Gap.v(AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: product.productSpecification
                  .take(3)
                  .map((text) => _InfoChip(label: text))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _CashHistoryCard extends StatelessWidget {
  const _CashHistoryCard({required this.giveawayHistory});

  final GiveawayHistory giveawayHistory;

  @override
  Widget build(BuildContext context) {
    final cash = giveawayHistory.cashGiveaway;
    final title = cash.cashName.isEmpty ? 'Cash giveaway' : cash.cashName;

    return _HistoryCardShell(
      accentColor: const Color(0xFF039855),
      backgroundColor: const Color(0xFFF0FFF8),
      icon: Icons.account_balance_wallet_outlined,
      child: Row(
        children: [
          Expanded(
            child: _HistoryTitleBlock(
              eyebrow: 'Cash claimed',
              title: '₦${cash.amountFixed}',
              subtitle: title,
              date: giveawayHistory.createdAt,
            ),
          ),
          Gap.h(AppSpacing.md),
          _ClaimedBadge(),
        ],
      ),
    );
  }
}

class _DataHistoryCard extends StatelessWidget {
  const _DataHistoryCard({required this.giveawayHistory});

  final GiveawayHistory giveawayHistory;

  @override
  Widget build(BuildContext context) {
    final isAirtime = giveawayHistory.isAirtimeGiveaway;
    final data = giveawayHistory.isDataGiveaway
        ? giveawayHistory.dataGiveaway
        : null;
    final network = data?.network.isNotEmpty == true
        ? data!.network
        : giveawayHistory.network;
    final title = isAirtime
        ? '₦${giveawayHistory.amount} ${giveawayHistory.giveawayType.name.capitalize}'
        : _formatDataSize(data?.dataSize ?? giveawayHistory.amount);
    final subtitle = isAirtime
        ? network.toUpperCase()
        : (data?.dataName.isNotEmpty == true
              ? data!.dataName
              : 'Data giveaway');

    return _HistoryCardShell(
      accentColor: const Color(0xFF1570EF),
      backgroundColor: const Color(0xFFF4F8FF),
      icon: Icons.wifi_tethering_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _NetworkAvatar(network: network),
              Gap.h(AppSpacing.md),
              Expanded(
                child: _HistoryTitleBlock(
                  eyebrow: isAirtime ? 'Airtime claimed' : 'Data claimed',
                  title: title,
                  subtitle: subtitle,
                  date: giveawayHistory.createdAt,
                ),
              ),
              _ClaimedBadge(),
            ],
          ),
          if (giveawayHistory.giveawayType.code == 'airtime-pin') ...[
            _HistoryDivider(),
            GiveawayPinSection(giveawayHistory: giveawayHistory),
          ],
        ],
      ),
    );
  }
}

class _HistoryCardShell extends StatelessWidget {
  const _HistoryCardShell({
    required this.child,
    required this.accentColor,
    required this.backgroundColor,
    required this.icon,
  });

  final Widget child;
  final Color accentColor;
  final Color backgroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accentColor.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: -8,
            child: Icon(
              icon,
              size: 72,
              color: accentColor.withValues(alpha: 0.08),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _HistoryTitleBlock extends StatelessWidget {
  const _HistoryTitleBlock({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: poppinsTextStyle(
            fontSize: 10,
            fontWeight: AppFontWeight.bold,
            color: const Color(0xFF667085),
          ),
        ),
        Gap.v(AppSpacing.xxs),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: poppinsTextStyle(
            fontSize: 16,
            fontWeight: AppFontWeight.bold,
            color: const Color(0xFF101828),
          ),
        ),
        Gap.v(AppSpacing.xxs),
        Text(
          '$subtitle • ${dateAgo(date)}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: poppinsTextStyle(fontSize: 11, color: const Color(0xFF667085)),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 58,
        height: 58,
        color: AppColors.white,
        child: image.isEmpty
            ? const Icon(Icons.card_giftcard, color: Color(0xFF7C3AED))
            : Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.card_giftcard, color: Color(0xFF7C3AED)),
              ),
      ),
    );
  }
}

class _NetworkAvatar extends StatelessWidget {
  const _NetworkAvatar({required this.network});

  final String network;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: getNetworkImage(network, width: 38, height: 38)),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: poppinsTextStyle(
          fontSize: 10,
          fontWeight: AppFontWeight.semiBold,
          color: const Color(0xFF344054),
        ),
      ),
    );
  }
}

class _HistoryDivider extends StatelessWidget {
  const _HistoryDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: _primaryColor.withValues(alpha: 0.2),
      ),
    );
  }
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
  return '${(parsed * 1000).round()}MB';
}

class GiveawayPinSection extends StatefulWidget {
  const GiveawayPinSection({super.key, required this.giveawayHistory});
  final GiveawayHistory giveawayHistory;

  @override
  State<GiveawayPinSection> createState() => _GiveawayPinSectionState();
}

class _GiveawayPinSectionState extends State<GiveawayPinSection> {
  GiveawayHistory get gHistory => widget.giveawayHistory;
  AirtimeGiveawayPin get aPin => gHistory.giveawayPin;

  bool _showPin = false;
  void _togglePin() => setState(() {
    _showPin = !_showPin;
  });
  void dial(AirtimeGiveawayPin pin) {
    final dial = pin.loadingCode ?? '*311*${pin.maskedPin}#';
    dialNumber(dial);
  }

  void copy(pin) {
    copyText(context, pin, 'Copied');
  }

  @override
  Widget build(BuildContext context) {
    final icon = _showPin ? Icons.visibility_off : Icons.visibility_outlined;

    final text = _showPin ? aPin.maskedPin : "****  ****  **** ****  ****";

    return Container(
      width: context.screenWidth * 0.8,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,
        children: [
          newMethod(icon: icon, text: text),
          Row(
            spacing: AppSpacing.lg,
            children: [
              Expanded(child: _DialButton(onTap: () => dial(aPin))),
              _CopyButton(onCopy: () => copy(aPin.maskedPin)),
            ],
          ),
        ],
      ),
    );
  }

  Container newMethod({required String text, required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        color: _primaryColor.withValues(alpha: 0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Expanded(
            child: Text(
              text,
              style: poppinsTextStyle(
                fontSize: 12,
                fontWeight: AppFontWeight.bold,
              ).copyWith(letterSpacing: 1.5, height: 1.5),
            ),
          ),
          Tappable.faded(
            onTap: _togglePin,
            child: Icon(icon, size: 16, color: _primaryColor),
          ),
        ],
      ),
    );
  }
}

//// COMPONENTS  ////
class _CopyButton extends StatelessWidget {
  const _CopyButton({this.onCopy});
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Tappable.faded(
      onTap: onCopy,
      child: Container(
        width: 66,
        height: 43,
        // padding: EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.grey.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Center(
          child: Icon(Icons.copy, size: 18, color: AppColors.white),
        ),
      ),
    );
  }
}

class _DialButton extends StatelessWidget {
  const _DialButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 32,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_primaryColor),
        fixedSize: WidgetStatePropertyAll(Size(190, 32)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
        ),
      ),
      text: '',
      onPressed: onTap,
      icon: Icon(Icons.phone_outlined, color: AppColors.white),
      child: Text(
        'Dial Pin',
        style: poppinsTextStyle(
          fontSize: 12,
          color: AppColors.white,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}

class _ClaimedBadge extends StatelessWidget {
  const _ClaimedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
      child: Text(
        'Claimed',
        style: poppinsTextStyle(
          fontSize: 11,
          fontWeight: AppFontWeight.bold,
          color: _primaryColor,
        ),
      ),
    );
  }
}
