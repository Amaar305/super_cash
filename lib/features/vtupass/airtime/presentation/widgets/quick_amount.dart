import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickAmount extends StatelessWidget {
  const QuickAmount({
    super.key,
    required this.onChanged,
    this.enabled = true,
  });
  final void Function(String value) onChanged;
  final bool enabled;
  final List<String> airtimePrices = const [
    "50",
    "100",
    "200",
    "500",
    "700",
    "1,000",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 24),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 1.1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 12,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: airtimePrices.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                elevation: 0.2,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(7),
                color: AppColors.white,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.4,
                      color: AppColors.lightBlueFilled,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap:
                        !enabled ? null : () => onChanged(airtimePrices[index]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'N${airtimePrices[index]}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                          Gap.v(2),
                          Text(
                            '2% Discount',
                            style: context.bodySmall?.copyWith(
                              fontWeight: AppFontWeight.thin,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // if (index < 3)
              Positioned(
                top: -1,
                right: 0,
                child: SizedBox.square(
                  dimension: 10,
                  child: Assets.icons.hot.svg(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
