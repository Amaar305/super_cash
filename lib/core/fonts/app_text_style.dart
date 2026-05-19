import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

TextStyle poppinsTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    fontWeight: fontWeight ?? AppFontWeight.regular,
    color: color,
  );
}
