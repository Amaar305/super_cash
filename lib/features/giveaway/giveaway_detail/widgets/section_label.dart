part of '../pages/giveway_detail_page.dart';

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: poppinsTextStyle(
        color: GivewayDetailPage._sectionTitle,
        fontSize: 11,
        fontWeight: AppFontWeight.semiBold,
      ),
    );
  }
}
