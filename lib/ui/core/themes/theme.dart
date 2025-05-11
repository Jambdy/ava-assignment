import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

abstract final class AppTheme {
  static const TextStyle detailEmphasis = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle detailRegular = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static TextStyle graphSmall = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );
  // TODO: get 'At Slam Cnd' font from UX
  static TextStyle graphMedium = GoogleFonts.bebasNeue(
    fontSize: 36.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
    height: 1
  );
  static const TextStyle overlineEmphasis = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle overlineRegular = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static const _textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.textWhite,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme,
    fontFamily: 'At Hauss',
    scaffoldBackgroundColor: AppColors.manilla,
  );
}
