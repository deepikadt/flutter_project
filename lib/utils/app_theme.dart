import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_hunt_app/utils/app_colors.dart';
import 'package:product_hunt_app/utils/app_fonts.dart';

class AppTheme {
  static AppTheme _appTheme;

  AppTheme._internal();

  factory AppTheme() {
    _appTheme = _appTheme ?? AppTheme._internal();

    return _appTheme;
  }

  /// returns light mode theme
  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      accentColor: AppColors.blue,
      primaryColor: AppColors.white,
      fontFamily: AppFonts.sfproDisplay,
      unselectedWidgetColor: AppColors.greyShade211,
      snackBarTheme: const SnackBarThemeData(
        elevation: 16.0,
        backgroundColor: AppColors.blue,
        contentTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      scaffoldBackgroundColor: AppColors.white,
      canvasColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            fontFamily: AppFonts.sfproDisplay,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: AppColors.grey,
        ),
      ),
      textTheme: TextTheme(
        // Bold 24 Black
        headline1: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        // Bold 16 Black
        headline2: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        // Extra-bold 32 white
        headline3: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          fontSize: 32.0,
          fontWeight: FontWeight.w800,
          color: AppColors.white,
        ),
        // Bold 10 Grey
        headline4: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.grey,
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
        ),
        // Bold 10 White
        headline5: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.white,
          fontSize: 10.0,
          fontWeight: FontWeight.w700,
        ),
        // Regular 10 Red
        headline6: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.red,
          fontSize: 12.0,
        ),
        // Regular 10 Grey
        subtitle1: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.grey,
          fontSize: 10.0,
        ),
        // Semi-bold 10 Blue
        subtitle2: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.blue,
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
        ),
        // Regular 12 Black
        bodyText1: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.black,
          fontSize: 12.0,
        ),
        // Light 12 White
        bodyText2: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w300,
        ),
        // Regular 10 White
        caption: TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.white.withOpacity(
            0.7,
          ),
          fontSize: 10.0,
        ),
        //Semi-Bold,10,blue
        button: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.blue,
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
        ),
        // Regular 8 Grey
        overline: const TextStyle(
          fontFamily: AppFonts.sfproDisplay,
          color: AppColors.grey,
          fontSize: 8.0,
        ),
      ),
    );
  }

  /// return dark mode theme
  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: const TextTheme(),
    );
  }
}
