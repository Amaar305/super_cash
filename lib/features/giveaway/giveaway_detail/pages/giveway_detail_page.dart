import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/app/routes/app_routes.dart';
import 'package:super_cash/app/view/app.dart';
import 'package:super_cash/core/fonts/app_text_style.dart';
import 'package:super_cash/features/giveaway/giveaway.dart';

part '../widgets/action_footer.dart';
part '../widgets/countdown_card.dart';
part '../widgets/countdown_section.dart';
part '../widgets/countdown_separator.dart';
part '../widgets/countdown_value.dart';
part '../widgets/description_section.dart';
part '../widgets/faq_section.dart';
part '../widgets/faq_tile.dart';
part '../widgets/hero_card.dart';
part '../widgets/hero_image.dart';
part '../widgets/how_it_works_section.dart';
part '../widgets/info_card.dart';
part '../widgets/metric_card.dart';
part '../widgets/metric_row.dart';
part '../widgets/section_label.dart';
part '../widgets/start_and_end_date.dart';
part '../widgets/status_badge.dart';
part '../widgets/step_card.dart';

class GivewayDetailPage extends StatelessWidget {
  const GivewayDetailPage({
    super.key,
    required this.giveaway,
    required this.destinationRouteName,
  });

  final Giveaway giveaway;
  final String destinationRouteName;

  static const _pageBackground = Color(0xFFF6F8F7);
  static const _heroTop = Color.fromARGB(255, 36, 56, 71);
  static const _heroBottom = Color.fromARGB(255, 14, 58, 90);
  static const _cardBorder = Color(0xFFE1E9E6);
  static const _softGreen = Color.fromARGB(255, 15, 71, 139);
  static const _softMuted = Color.fromARGB(255, 123, 133, 139);
  static const _sectionTitle = Color.fromARGB(255, 2, 18, 29);
  static const _primaryCta = AppColors.background2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GiveawayDetailCubit(
        checkGiveawayEligibilityUseCase: serviceLocator(),
      ),
      child: _GivewayDetailView(
        giveaway: giveaway,
        destinationRouteName: destinationRouteName,
      ),
    );
  }
}

class _GivewayDetailView extends StatelessWidget {
  const _GivewayDetailView({
    required this.giveaway,
    required this.destinationRouteName,
  });

  final Giveaway giveaway;
  final String destinationRouteName;

  @override
  Widget build(BuildContext context) {
    final details = _GiveawayDetails.from(giveaway);
    final giveawayTypeId = giveaway.giveawayType.id.toString();

    return BlocListener<GiveawayDetailCubit, GiveawayDetailState>(
      listener: (context, state) {
        if (state.status.isFailure || state.status.isNotEligible) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
          return;
        }

        if (state.status.isEligible) {
          // openSnackbar(
          //   SnackbarMessage.success(title: state.message),
          //   clearIfQueue: true,
          // );

          if (details.isProductGiveaway) {
            context.pushNamed(
              destinationRouteName,
              pathParameters: {'giveaway_type_id': giveawayTypeId},
              extra: giveaway.status == UpcomingGiveawayStatus.upcoming
                  ? false
                  : true,
            );

            return;
          }

          if (state.shouldNavigateOnSuccess) {
            context.pushNamed(
              destinationRouteName,
              pathParameters: {'giveaway_type_id': giveawayTypeId},
              extra: giveaway.status == UpcomingGiveawayStatus.upcoming
                  ? false
                  : true,
            );
          }
        }
      },
      child: AppScaffold(
        appBar: AppBar(
          backgroundColor: GivewayDetailPage._pageBackground,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          leading: AppLeadingAppBarWidget(
            onTap: () => Navigator.of(context).maybePop(),
          ),
          title: AppAppBarTitle('Giveaway Details'),
        ),
        bottomNavigationBar: _ActionFooter(
          details: details,
          giveawayTypeId: giveawayTypeId,
        ),
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
              const Gap.v(16),
              _HowItWorksSection(details: details),
              const Gap.v(18),
              _FaqSection(details: details),
              const Gap.v(10),
            ],
          ),
        ),
      ),
    );
  }
}

class GivewayDetailRouteData {
  const GivewayDetailRouteData({
    required this.giveaway,
    required this.destinationRouteName,
  });

  factory GivewayDetailRouteData.fromGiveaway(Giveaway giveaway) {
    return GivewayDetailRouteData(
      giveaway: giveaway,
      destinationRouteName: destinationRouteNameFor(giveaway),
    );
  }

  final Giveaway giveaway;
  final String destinationRouteName;

  static String destinationRouteNameFor(Giveaway giveaway) {
    final code = giveaway.giveawayType.code;

    if (code == 'airtime-direct') return RNames.directAirtimeGiveaway;
    if (code.contains('airtime')) return RNames.airtimeGiveaway;
    if (code.contains('product')) return RNames.productGiveaway;
    if (code.contains('data')) return RNames.dataGiveaway;
    if (code.contains('cash')) return RNames.cashGiveaway;

    return RNames.giveaway;
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
    required this.giveawayType,
    required this.upcomingGiveawayStatus,
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
      giveawayType: giveaway.giveawayType,
      upcomingGiveawayStatus: giveaway.status,
      isClosed:
          giveaway.status.isCancelled ||
          giveaway.status.isCompleted ||
          !giveaway.status.isOngoing ||
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
  final GiveawayType giveawayType;
  final UpcomingGiveawayStatus upcomingGiveawayStatus;

  String get _giveawayTypeCode => giveawayType.code.toLowerCase();

  bool get isAirtimeGiveaway => _giveawayTypeCode == 'airtime-pin';

  bool get isDirectAirtimeGiveaway =>
      _giveawayTypeCode.contains('direct') &&
      _giveawayTypeCode.contains('airtime');

  bool get isDataGiveaway => _giveawayTypeCode.contains('data');

  bool get isCashGiveaway => _giveawayTypeCode.contains('cash');

  bool get isProductGiveaway => _giveawayTypeCode.contains('product');

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
