part of '../pages/product_giveaway_details_page.dart';

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
