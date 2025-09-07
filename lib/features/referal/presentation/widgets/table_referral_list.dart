import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/referal/referal.dart';

class StatusTableCard extends StatelessWidget {
  const StatusTableCard({super.key, required this.users});

  final List<ReferralUser> users;

  // Compact layout constants
  static const double _nameColW = 80;
  static const double _colW = 100;
  static const double _rewardColW = 180; // a bit wider to show amount + labels
  static const double _headerH = 48;
  static const double _rowH = 52;
  static const EdgeInsets _cellPad = EdgeInsets.symmetric(horizontal: 12);

  // Typography
  static const _headerTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF3D3D3D),
  );
  static const _cellTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    final totalWidth = _nameColW + _colW + _colW + _rewardColW;
    final tableHeight = _headerH + 1 + (_rowH * users.length);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: const Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.2),
              blurRadius: 19,
              spreadRadius: 0,
            ),
          ],
        ),
        child: SizedBox(
          height: tableHeight, // finite height prevents layout errors
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: totalWidth,
              child: Column(
                children: [
                  _header(),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE9ECEF),
                  ),
                  for (int i = 0; i < users.length; i++)
                    _dataRow(users[i], isLast: i == users.length - 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      height: _headerH,
      color: const Color(0xFFF7F7F7),
      child: Row(
        children: [
          _headerCell('NAME', _nameColW, TextAlign.left),
          _headerCell('ACTIVE', _colW, TextAlign.center),
          _headerCell('VERIFIED', _colW, TextAlign.center),
          _headerCell('REWARD STATUS', _rewardColW, TextAlign.center),
        ],
      ),
    );
  }

  static Widget _headerCell(String text, double width, TextAlign align) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: _cellPad,
        child: Align(
          alignment: align == TextAlign.left
              ? Alignment.centerLeft
              : Alignment.center,
          child: Text(text, textAlign: align, style: _headerTextStyle),
        ),
      ),
    );
  }

  Widget _dataRow(ReferralUser u, {required bool isLast}) {
    return Container(
      height: _rowH,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : const Color(0xFFE9ECEF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // NAME
          SizedBox(
            width: _nameColW,
            child: Padding(
              padding: _cellPad,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  u.username,
                  style: _cellTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          // ACTIVE
          _statusCell(ok: u.active),
          // VERIFIED
          _statusCell(ok: u.verified),
          // REWARD STATUS
          SizedBox(
            width: _rewardColW,
            child: Padding(
              padding: _cellPad,
              child: Center(
                child: Text(
                  _rewardStatusText(u),
                  style: _cellTextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----- Reward/Eligibility logic -----
  static String _rewardStatusText(ReferralUser u, {String symbol = '₦'}) {
    // build amount string (if any)
    final hasAmount = u.rewardAmount > 0;
    final amt = hasAmount ? '$symbol${_formatAmount(u.rewardAmount)}' : '';

    // Highest-priority states first
    if (u.suspended) {
      // Suspended takes precedence
      return 'Suspended';
    }

    if (u.rewarded) {
      // Claimed already
      final when = _formatDate(u.rewardClaimedAt);
      return hasAmount
          ? (when.isNotEmpty ? 'CLAIMED $amt • $when' : 'CLAIMED $amt')
          : (when.isNotEmpty ? 'CLAIMED • $when' : 'CLAIMED');
    }

    if (u.expired) {
      final when = _formatDate(u.expiredAt);
      return when.isNotEmpty ? 'Expired • $when' : 'Expired';
    }

    if (u.eligible) {
      final ttl = u.expiresInDays;
      final ttlText = ttl <= 0 ? 'Expires today' : 'Expires in ${ttl}d';
      return hasAmount ? 'Eligible $amt • $ttlText' : 'Eligible • $ttlText';
    }

    // If not eligible/expired/rewarded/suspended, show neutral/pending state
    return hasAmount ? '$amt • Pending' : '-';
  }

  // Formats numbers like 1,234 or 1,234.50 without requiring intl
  static String _formatAmount(double amount) {
    final isWhole = amount.truncateToDouble() == amount;
    final fixed = isWhole
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
    final parts = fixed.split('.');
    final intPart = parts[0];
    final frac = parts.length > 1 ? parts[1] : null;
    final intWithCommas = intPart.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return frac == null ? intWithCommas : '$intWithCommas.$frac';
  }

  static String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    String two(int n) => n < 10 ? '0$n' : '$n';
    return '${dt.year}-${two(dt.month)}-${two(dt.day)}';
  }

  // ----- Active/Verified circle status -----
  static Widget _statusCell({required bool ok}) {
    final Color color = ok ? const Color(0xFF2E7D32) : const Color(0xFFD32F2F);
    final IconData icon = ok ? Icons.check : Icons.close;

    return SizedBox(
      width: _colW,
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: color, width: 1),
          ),
          child: Center(child: Icon(icon, size: 12, color: color)),
        ),
      ),
    );
  }
}
