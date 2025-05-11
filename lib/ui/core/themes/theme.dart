import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

abstract final class AppTheme {
  static const TextStyle bodyEmphasis = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle detailEmphasis = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle detailRegular = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static TextStyle interSmallBold = GoogleFonts.inter(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
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
    height: 0.8,
  );
  static const TextStyle overlineEmphasis = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle overlineRegular = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle smallEmphasis = TextStyle(
    fontSize: 8.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle title = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    // TODO: get 'At Hauss' font from UX
    fontFamily: 'Liter',
    scaffoldBackgroundColor: AppColors.manilla,
  );
}
