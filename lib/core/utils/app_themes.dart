import 'package:booki_app/core/constants/asset_fonts.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData themeData = ThemeData(
      fontFamily: AssetFonts.DMSerifDisplay,
      scaffoldBackgroundColor: AppColors.whiteColor,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.accentColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.redColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: AppColors.redColor,
            ),
          )),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.darkColor,
        ),
      ));
}
