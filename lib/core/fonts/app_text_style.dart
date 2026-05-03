import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle poppinsTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return GoogleFonts.poppins(
    fontSize: fontSize,
    fontWeight: fontWeight ?? AppFontWeight.regular,
    color: color,
  );
}
