import 'package:flutter/material.dart';

const String _fontFamily = 'Mont';
const String _fontFamilySemibold = 'Mont_Semibold';
const String _fontFamilyBold = 'Mont_Bold';

class AppTheme {
  static const Color white = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x33262626);
  static const Color mainBackgroundColor = white;
  static const Color textColor = Color(0xFF071E23);
  static const Color surface = Color(0xFFF3F1F8);
  static const Color mainColor = Color(0xFF031997);
  static const Color grayFonColor = Color(0xFFF3F1F8);
  static const Color grayFon1Color = Color(0xFFF3F1F8);
  static const Color grayFon2Color = Color(0xFFE1E0E5);
  static const Color grayFon3Color = Color(0xFF88868D);
  static const Color grayFonDarkestColor = Color(0xFF4F4F4F);

  static const Color intenseBlueColor = Color(0xFF107AF6);
  static const Color extraBlueColor = Color(0xFF51ABFF);
  static const Color extraBlueLightColor = Color(0xFFE2F8FF);
  static const Color extraRedColor = Color(0xFFF3612C);
  static const Color extraRedLightColor = Color(0xFFFFEAE2);
  static const Color extraYellowColor = Color(0xFFFFB428);
  static const Color extraYellowLightColor = Color(0xFFFFF7E9);

  static ThemeData mainTheme = ThemeData(
    colorScheme: const ColorScheme.light(
        primary: mainColor,
        onPrimary: mainBackgroundColor,
        onSecondary: mainColor,
        background: grayFon1Color,
        onBackground: textColor,
        surface: mainBackgroundColor,
        surfaceContainer: surface,
        onInverseSurface: grayFon3Color,
        error: extraRedColor,
        tertiary: extraYellowColor,
        outline: grayFon2Color,
        onSurface: textColor),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: mainColor,
        selectionColor: mainColor.withAlpha(100),
        selectionHandleColor: mainColor),
    textTheme: TextTheme(
        bodyMedium: textMain14,
        bodySmall: textMain12,
        bodyLarge: textMain16,
        labelSmall: semibold12,
        labelMedium: semibold14,
        labelLarge: semibold16,
        titleSmall: bold16,
        titleMedium: bold20,
        titleLarge: bold22,
        headlineLarge: bold18),
  );


  static TextStyle textMain14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textColor,
    letterSpacing: 0.02,
    fontStyle: FontStyle.normal,
    fontFamily: _fontFamily,
    decoration: TextDecoration.none,
  );
  static TextStyle textMain20 = textMain14.copyWith(fontSize: 20);
  static TextStyle textMain16 = textMain14.copyWith(fontSize: 16);
  static TextStyle textMain12 = textMain14.copyWith(fontSize: 12);
  static TextStyle textMain10 = textMain14.copyWith(fontSize: 10);

  static TextStyle semibold14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: textColor,
    fontFamily: _fontFamilySemibold,
    letterSpacing: 0.02,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  );
  static TextStyle semibold16 = semibold14.copyWith(fontSize: 16);
  static TextStyle semibold12 = semibold14.copyWith(fontSize: 12);

  static TextStyle bold14 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: textColor,
    letterSpacing: 0.02,
    fontFamily: _fontFamilyBold,
    fontStyle: FontStyle.normal,
    decoration: TextDecoration.none,
  );
  static TextStyle bold16 = bold14.copyWith(fontSize: 16);
  static TextStyle bold18 = bold14.copyWith(fontSize: 18);
  static TextStyle bold20 = bold14.copyWith(fontSize: 20);
  static TextStyle bold22 = bold14.copyWith(fontSize: 22);
  static TextStyle bold12 = bold14.copyWith(fontSize: 12);

  static TextStyle noteStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
    letterSpacing: 0.02,
    fontStyle: FontStyle.normal,
    fontFamily: 'Marck',
    decoration: TextDecoration.none,
  );
}
