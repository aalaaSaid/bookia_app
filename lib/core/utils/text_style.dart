import 'package:booki_app/core/constants/asset_fonts.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle getHeadlineTextStyle({double fontSize = 30, Color? color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.darkColor,
  );
}

TextStyle getTitleTextStyle({double fontSize = 24, Color? color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.darkColor,
  );
}

TextStyle getSubTitleTextStyle({double fontSize = 20, Color? color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.darkColor,
    fontFamily: AssetFonts.DMSerifDisplay,
  );
}

TextStyle getBodyTextStyle({double fontSize = 18, Color? color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.darkColor,
    fontFamily: AssetFonts.DMSerifDisplay,
  );
}

TextStyle getSmallTextStyle({double fontSize = 15, Color? color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.darkColor,
    fontFamily: AssetFonts.DMSerifDisplay,
  );
}
