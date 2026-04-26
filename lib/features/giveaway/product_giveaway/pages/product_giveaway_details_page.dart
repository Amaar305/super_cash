import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

class ProductGiveawayDetailsPage extends StatelessWidget {
  const ProductGiveawayDetailsPage({super.key, required this.giveaway});

  final Giveaway giveaway;

  static const _pageBackground = Color(0xFFF6F8F7);
  static const _heroTop = Color.fromARGB(255, 36, 56, 71);
  static const _heroBottom = Color.fromARGB(255, 14, 58, 90);
  static const _cardBorder = Color(0xFFE1E9E6);
  static const _softGreen = Color.fromARGB(255, 15, 71, 139);
  static const _softMuted = Color.fromARGB(255, 123, 133, 139);
  static const _sectionTitle = Color.fromARGB(255, 2, 18, 29);
  static const _primaryCta = AppColors.blue;

  @override
  Widget build(BuildContext context) {
    final details = _GiveawayDetails.from(giveaway);

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: _pageBackground,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: AppLeadingAppBarWidget(
          onTap: () => Navigator.of(context).maybePop(),
        ),
        title: AppAppBarTitle('Giveaway Details'),
      ),
      bottomNavigationBar: _ActionFooter(details: details),
      body: AppConstrainedScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(details: details),
            const Gap.v(18),
            _DescriptionSection(details: details),
            const Gap.v(10),
            _MetricRow(details: details),
            const Gap.v(10),
            _StartAndEndDate(giveaway: giveaway),
            const Gap.v(10),
            _CountdownSection(details: details),
            const Gap.v(10),
            _HowItWorksSection(details: details),
            const Gap.v(18),
            _FaqSection(details: details),
            const Gap.v(10),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ProductGiveawayDetailsPage._heroTop,
            ProductGiveawayDetailsPage._heroBottom,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(child: _HeroImage(imageUrl: details.imageUrl)),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.10),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.black.withValues(alpha: 0.42),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatusBadge(text: details.statusBadgeText),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 190),
                    child: Text(
                      details.heroTitle,
                      style: poppinsTextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Color(0xFFDDE9E5),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        details.countdownLabel,
                        style: poppinsTextStyle(
                          color: const Color(0xFFDDE9E5),
                          fontSize: 11,
                          fontWeight: AppFontWeight.medium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().startsWith('http')) {
      return Align(
        alignment: Alignment.centerRight,
        child: Transform.translate(
          offset: const Offset(30, 6),
          child: SizedBox(
            width: 170,
            height: 150,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _fallback(),
            ),
          ),
        ),
      );
    }

    return _fallback();
  }

  Widget _fallback() {
    return Align(
      alignment: Alignment.centerRight,
      child: Opacity(
        opacity: 0.24,
        child: Transform.translate(
          offset: const Offset(20, 8),
          child: Assets.images.mtn.image(fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: poppinsTextStyle(
          color: AppColors.white,
          fontSize: 9,
          fontWeight: AppFontWeight.semiBold,
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            title: 'Total Value',
            value: details.valueToWin,
            subtitle: details.valueSupportText,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _MetricCard(
            title: 'Total Winners',
            value: details.totalWinners,
            subtitle: details.winnerSupportText,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsTextStyle(
              color: ProductGiveawayDetailsPage._softMuted,
              fontSize: 10,
              fontWeight: AppFontWeight.medium,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: poppinsTextStyle(
              color: const Color.fromARGB(255, 39, 43, 42),
              fontSize: 24,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                size: 12,
                color: ProductGiveawayDetailsPage._softGreen,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  subtitle,
                  style: poppinsTextStyle(
                    color: ProductGiveawayDetailsPage._softGreen,
                    fontSize: 10,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StartAndEndDate extends StatelessWidget {
  const _StartAndEndDate({required this.giveaway});
  final Giveaway giveaway;

  @override
  Widget build(BuildContext context) {
    if (giveaway.startsAt == null || giveaway.endsAt == null) {
      return SizedBox.shrink();
    }
    return Row(
      spacing: AppSpacing.lg,
      children: [
        Expanded(
          child: _InfoCard(
            title: 'STARTS ON',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.blue,
            titleColor: Color(0xFF64748B),
            child: FittedBox(
              child: Text(
                formatDateTime(giveaway.startsAt!),
                style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
              ),
            ),
          ),
        ),
        Expanded(
          child: _InfoCard(
            title: 'ENDS ON',
            icon: Icons.calendar_month_outlined,
            iconColor: AppColors.red,
            titleColor: Color(0xFF64748B),
            child: FittedBox(
              child: Text(
                formatDateTime(giveaway.endsAt!),
                style: poppinsTextStyle(fontWeight: AppFontWeight.semiBold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      title: 'Description',
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.blue,
      titleColor: const Color(0xFF1B2740),
      child: Text(
        details.description,
        style: poppinsTextStyle(
          color: const Color(0xFF5F6F89),
          fontSize: 11,
          fontWeight: AppFontWeight.medium,
        ),
      ),
    );
  }
}

class _CountdownSection extends StatelessWidget {
  const _CountdownSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    if (details.countdownTarget == null) {
      return const SizedBox.shrink();
    }

    return _CountdownCard(
      title: details.countdownCardTitle,
      target: details.countdownTarget!,
      hasEnded: details.isClosed,
    );
  }
}

class _CountdownCard extends StatefulWidget {
  const _CountdownCard({
    required this.title,
    required this.target,
    required this.hasEnded,
  });

  final String title;
  final DateTime target;
  final bool hasEnded;

  @override
  State<_CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<_CountdownCard> {
  late Duration remaining;

  @override
  void initState() {
    super.initState();
    remaining = _timeLeft();
  }

  Duration _timeLeft() {
    final diff = widget.target.difference(DateTime.now());
    if (diff.isNegative) return Duration.zero;
    return diff;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream<int>.periodic(const Duration(minutes: 1), (x) => x),
      builder: (context, snapshot) {
        remaining = _timeLeft();
        final days = remaining.inDays;
        final hours = remaining.inHours % 24;
        final minutes = remaining.inMinutes % 60;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border(
              left: BorderSide(color: AppColors.deepBlue, width: 4),
              top: BorderSide(color: AppColors.deepBlue, width: 1),
              bottom: BorderSide(color: AppColors.deepBlue, width: 1),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            spacing: 16,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.hasEnded ? 'GIVEAWAY CLOSED' : widget.title,
                  style: poppinsTextStyle(
                    color: AppColors.blue,
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CountdownValue(
                    value: days.toString().padLeft(2, '0'),
                    label: 'DAYS',
                  ),
                  const _CountdownSeparator(),
                  _CountdownValue(
                    value: hours.toString().padLeft(2, '0'),
                    label: 'HOURS',
                  ),
                  const _CountdownSeparator(),
                  _CountdownValue(
                    value: minutes.toString().padLeft(2, '0'),
                    label: 'MINS',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CountdownValue extends StatelessWidget {
  const _CountdownValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: poppinsTextStyle(
                color: AppColors.black,
                fontSize: 30,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: poppinsTextStyle(
              color: const Color(0xFF94A3B8),
              fontSize: 10,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: poppinsTextStyle(
          color: const Color(0xFF045A4E),
          fontSize: 30,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.titleColor,
    required this.child,
    this.accentColor,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Color titleColor;
  final Widget child;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E8F0)),
      ),
      child: Stack(
        children: [
          if (accentColor != null)
            Positioned(
              left: -18,
              top: -18,
              bottom: -16,
              child: Container(width: 6, color: accentColor),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 22),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: poppinsTextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              child,
            ],
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final steps = <_StepData>[
      _StepData(
        number: 1,
        title: 'Join Giveaway',
        description:
            'Click the enter button below to register your interest in this session.',
      ),
      _StepData(
        number: 2,
        title: 'Wait for Selection',
        description:
            'Our system randomly selects winners from registered users during the event.',
      ),
      _StepData(
        number: 3,
        title: details.finalStepTitle,
        description: details.finalStepDescription,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'HOW IT WORKS'),
        const SizedBox(height: 10),
        ...steps.map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _StepCard(step: step),
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final _StepData step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ProductGiveawayDetailsPage._primaryCta,
            ),
            child: Center(
              child: Text(
                '${step.number}',
                style: poppinsTextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: poppinsTextStyle(
                    color: const Color(0xFF304641),
                    fontSize: 13,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step.description,
                  style: poppinsTextStyle(
                    color: ProductGiveawayDetailsPage._softMuted,
                    fontSize: 10,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final items = <_FaqData>[
      _FaqData(
        question: 'How do I claim my prize?',
        answer: details.claimAnswer,
      ),
      _FaqData(
        question: 'Is there a limit per user?',
        answer: details.limitAnswer,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel(text: 'COMMON QUESTIONS'),
        const SizedBox(height: 10),
        ...items.asMap().entries.map(
          (entry) => AnimatedPadding(
            duration: 200.ms,
            padding: EdgeInsets.only(
              bottom: entry.key == items.length - 1 ? 0 : 8,
            ),
            child: _FaqTile(
              item: entry.value,
              initiallyExpanded: entry.key == 0,
            ),
          ),
        ),
      ],
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.item, required this.initiallyExpanded});

  final _FaqData item;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ProductGiveawayDetailsPage._cardBorder),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          iconColor: const Color(0xFF60756E),
          collapsedIconColor: const Color(0xFF60756E),
          title: Text(
            item.question,
            style: poppinsTextStyle(
              color: const Color(0xFF304641),
              fontSize: 12,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          children: [
            Text(
              item.answer,
              style: poppinsTextStyle(
                color: ProductGiveawayDetailsPage._softMuted,
                fontSize: 10,
                fontWeight: AppFontWeight.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: poppinsTextStyle(
        color: ProductGiveawayDetailsPage._sectionTitle,
        fontSize: 11,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }
}

class _ActionFooter extends StatelessWidget {
  const _ActionFooter({required this.details});

  final _GiveawayDetails details;

  @override
  Widget build(BuildContext context) {
    final isDisabled = details.isClosed;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        decoration: const BoxDecoration(
          color: ProductGiveawayDetailsPage._pageBackground,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 18,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isDisabled ? null : () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ProductGiveawayDetailsPage._primaryCta,
                  disabledBackgroundColor: const Color.fromARGB(
                    255,
                    184,
                    192,
                    199,
                  ),
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(54),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.how_to_reg_rounded, size: 18),
                label: Text(
                  'Enter Giveaway',
                  style: poppinsTextStyle(
                    color: AppColors.white,
                    fontSize: 13,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 227, 229, 232),
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: Color(0xFFD6E0DC)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.verified_user_outlined, size: 18),
                label: Text(
                  'Check Eligibility',
                  style: poppinsTextStyle(
                    color: const Color.fromARGB(255, 33, 34, 33),
                    fontSize: 12,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GiveawayDetails {
  const _GiveawayDetails({
    required this.imageUrl,
    required this.heroTitle,
    required this.statusBadgeText,
    required this.countdownLabel,
    required this.valueToWin,
    required this.totalWinners,
    required this.valueSupportText,
    required this.winnerSupportText,
    required this.description,
    required this.rules,
    required this.finalStepTitle,
    required this.finalStepDescription,
    required this.claimAnswer,
    required this.limitAnswer,
    required this.isClosed,
    required this.countdownTarget,
    required this.countdownCardTitle,
  });

  factory _GiveawayDetails.from(Giveaway giveaway) {
    final endsAt = giveaway.endsAt;
    final startsAt = giveaway.startsAt;
    final typeName = _normalize(giveaway.giveawayType.name);
    final description = _normalize(giveaway.description).isNotEmpty
        ? _normalize(giveaway.description)
        : _normalize(giveaway.giveawayType.description);
    final valueToWin = _normalize(giveaway.valueToWin).isNotEmpty
        ? _normalize(giveaway.valueToWin)
        : typeName;
    final totalWinners = _normalize(giveaway.numberOfUsers).isNotEmpty
        ? _normalize(giveaway.numberOfUsers)
        : '0';
    final rules = _rulesFrom(giveaway.participantEligibity, endsAt);
    final isProductGiveaway = giveaway.giveawayType.code.contains('product');

    return _GiveawayDetails(
      imageUrl: _normalize(giveaway.image),
      heroTitle: _heroTitle(typeName),
      statusBadgeText: _statusBadge(giveaway.status),
      countdownLabel: _countdownLabel(
        status: giveaway.status,
        startsAt: startsAt,
        endsAt: endsAt,
      ),
      valueToWin: valueToWin,
      totalWinners: totalWinners,
      valueSupportText: _valueSupportText(giveaway.status, endsAt),
      winnerSupportText: '$totalWinners winner slots',
      description: description,
      rules: rules,
      finalStepTitle: isProductGiveaway ? 'Claim Reward' : 'Claim Prize',
      finalStepDescription: isProductGiveaway
          ? 'If you win, your reward update appears in your dashboard instantly.'
          : 'If you win, your prize appears in your dashboard for immediate use.',
      claimAnswer: _claimAnswer(isProductGiveaway, endsAt),
      limitAnswer: rules.first,
      countdownTarget: giveaway.status == UpcomingGiveawayStatus.upcoming
          ? startsAt
          : endsAt,
      countdownCardTitle: giveaway.status == UpcomingGiveawayStatus.upcoming
          ? 'COUNTDOWN TO START'
          : 'COUNTDOWN TO END',
      isClosed:
          giveaway.status.isCancelled ||
          giveaway.status.isCompleted ||
          (endsAt != null && endsAt.isBefore(DateTime.now())),
    );
  }

  final String imageUrl;
  final String heroTitle;
  final String statusBadgeText;
  final String countdownLabel;
  final String valueToWin;
  final String totalWinners;
  final String valueSupportText;
  final String winnerSupportText;
  final String description;
  final List<String> rules;
  final String finalStepTitle;
  final String finalStepDescription;
  final String claimAnswer;
  final String limitAnswer;
  final bool isClosed;
  final DateTime? countdownTarget;
  final String countdownCardTitle;

  static String _normalize(String value) => value.trim();

  static String _heroTitle(String typeName) {
    final upper = typeName.toUpperCase();
    return upper.contains('GIVEAWAY') ? upper : '$upper GIVEAWAY';
  }

  static String _statusBadge(UpcomingGiveawayStatus status) {
    switch (status) {
      case UpcomingGiveawayStatus.ongoing:
        return 'LIVE GIVEAWAY';
      case UpcomingGiveawayStatus.completed:
        return 'ENDED GIVEAWAY';
      case UpcomingGiveawayStatus.cancelled:
        return 'CANCELLED GIVEAWAY';
      case UpcomingGiveawayStatus.upcoming:
        return 'UPCOMING GIVEAWAY';
    }
  }

  static String _countdownLabel({
    required UpcomingGiveawayStatus status,
    required DateTime? startsAt,
    required DateTime? endsAt,
  }) {
    if (status.isCancelled) return 'Giveaway cancelled';
    if (status.isCompleted) return 'Giveaway ended';

    if (status == UpcomingGiveawayStatus.upcoming && startsAt != null) {
      return 'Starts in ${_relativeTime(startsAt)}';
    }

    if (endsAt != null) {
      if (endsAt.isBefore(DateTime.now())) return 'Giveaway ended';
      return 'Ends in ${_relativeTime(endsAt)}';
    }

    return 'Live giveaway';
  }

  static String _relativeTime(DateTime target) {
    final diff = target.difference(DateTime.now());
    if (diff.isNegative) return '0m';

    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    if (days > 0) return '${days}d ${hours}h';
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${diff.inMinutes.clamp(0, 59)}m';
  }

  static String _valueSupportText(
    UpcomingGiveawayStatus status,
    DateTime? endsAt,
  ) {
    if (status == UpcomingGiveawayStatus.ongoing) return 'Live reward pool';
    if (status == UpcomingGiveawayStatus.upcoming && endsAt != null) {
      return 'Ends ${formatDateTime(endsAt).split(',').first}';
    }
    if (status.isCompleted) return 'Giveaway completed';
    if (status.isCancelled) return 'Giveaway cancelled';
    return 'Prize details available';
  }

  static List<String> _rulesFrom(String raw, DateTime? endsAt) {
    final normalized = raw
        .split(RegExp(r'[\n\r]+|(?<=[.!?])\s+'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (normalized.isNotEmpty) {
      return normalized.take(4).toList();
    }

    return [
      'Participation is limited to eligible users with an active profile.',
      'Each user can only maintain one valid entry for this giveaway session.',
      if (endsAt != null) 'Entries close on ${formatDateTime(endsAt)}.',
      'Winners are selected through a fair randomized process.',
    ];
  }

  static String _claimAnswer(bool isProductGiveaway, DateTime? endsAt) {
    if (isProductGiveaway) {
      return endsAt == null
          ? 'Once you are selected, your reward instructions will be shared directly from your dashboard.'
          : 'Once the giveaway ends, selected winners receive reward instructions directly on their dashboard.';
    }

    return 'If you win, your prize will be delivered to your dashboard once the selection is complete.';
  }
}

class _StepData {
  const _StepData({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;
}

class _FaqData {
  const _FaqData({required this.question, required this.answer});

  final String question;
  final String answer;
}
