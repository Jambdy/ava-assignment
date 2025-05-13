import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

abstract final class AppTheme {
  static const TextStyle bodyEmphasis = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle detailEmphasis = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle detailRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static final TextStyle interSmallBold = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryDark,
  );
  static final TextStyle graphSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  // TODO: get 'At Slam Cnd' font from UX
  static final TextStyle graphMedium = GoogleFonts.bebasNeue(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
    height: 0.8,
  );
  static const TextStyle overlineEmphasis = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle overlineRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle smallEmphasis = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );
  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
  );

  // TODO: get 'At Slam Cnd' font from UX, update size to 40
  static final TextStyle titleLarge = GoogleFonts.oswald(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimaryDark,
    letterSpacing: -0.5,
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray),
        ),
        filled: true,
        fillColor: AppColors.bgWhite,
        hintStyle: bodyRegular.copyWith(color: AppColors.textLight),
      );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.avaPrimary,
          foregroundColor: AppColors.textWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyEmphasis.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textWhite,
          ),
          fixedSize: const Size.fromHeight(44),
        ),
      );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.bgWhite,
          foregroundColor: AppColors.avaPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.avaPrimary, width: 2),
          textStyle: bodyEmphasis.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.avaPrimary,
          ),
          fixedSize: const Size.fromHeight(44),
        ),
      );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    // TODO: get 'At Hauss' font from UX
    fontFamily: 'Liter',
    elevatedButtonTheme: _elevatedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    scaffoldBackgroundColor: AppColors.manilla,
  );
}
