// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ///LIGHT MODE
  ///

  static const Color _scaffoldColorLight = Color(0xffffffff);

  static const Color _primaryColorLight = Color(0xff000000);
  static const Color _secondaryColorLight = Color(0xffcb997e);

  static const Color _errorColorLight = Color(0xffb00020);

  ///DARK MODE
  ///
  static const Color _scaffoldColorDark = Color(0xff121212);

  static const Color _primaryColorDark = Color(0xffb7b7a4);
  static const Color _secondaryColorDark = Color(0xffffe8d6);

  static const Color _errorColorDark = Color(0xffcf6679);

  static ThemeData light() {
    return ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily,
      primaryColor: Colors.black,
    ).copyWith(
      primaryColor: _primaryColorLight,
      primaryColorDark: _primaryColorLight,
      primaryColorLight: _primaryColorLight,
      errorColor: _errorColorLight,
      scaffoldBackgroundColor: _scaffoldColorLight,
      disabledColor: Colors.grey.withOpacity(0.50),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: _primaryColorLight,
        secondary: _secondaryColorLight,
        error: _errorColorLight,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: (32).r,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: (28).r,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: (24).r,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.75,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: (20).r,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.50,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: (18.r),
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          fontSize: (16).r,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: Colors.black,
        ),
        labelLarge: TextStyle(
          fontSize: (16).r,
          letterSpacing: 0.15,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          fontSize: (14).r,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        labelSmall: TextStyle(
          fontSize: (12).r,
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      primaryColor: _primaryColorDark,
      primaryColorDark: _primaryColorDark,
      primaryColorLight: _secondaryColorDark,
      errorColor: _errorColorDark,
      scaffoldBackgroundColor: _scaffoldColorDark,
      disabledColor: Colors.grey.withOpacity(0.50),
      splashColor: Colors.white.withOpacity(0.50),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _primaryColorDark,
        secondary: _secondaryColorDark,
        error: _errorColorDark,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: (32),
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
        ),
        headline2: TextStyle(
          fontSize: (28),
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
        ),
        headline3: TextStyle(
          fontSize: (24),
          fontWeight: FontWeight.w800,
          letterSpacing: -0.75,
        ),
        headline4: TextStyle(
          fontSize: (20),
          fontWeight: FontWeight.w800,
          letterSpacing: -0.50,
        ),
        headline5: TextStyle(
          fontSize: (18),
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),

        headline6: TextStyle(
          fontSize: (16),
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
        ),
        subtitle1: TextStyle(
          fontSize: (16),
          letterSpacing: 0.15,
        ),
        subtitle2: TextStyle(
          fontSize: (14),
          letterSpacing: 0.1,
          fontWeight: FontWeight.w600,
        ),
        caption: TextStyle(
          fontSize: (12),
        ),
        bodyText1: TextStyle(
          fontSize: (16),
          letterSpacing: 0,
        ),
        bodyText2: TextStyle(
          fontSize: (14),
          letterSpacing: 0.25,
        ),

        //BUTTON
        button: TextStyle(
          fontSize: (11),
          letterSpacing: 1.25,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}
