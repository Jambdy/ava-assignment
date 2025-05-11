import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color avaPrimary = Color(0xFF420085);
  static const Color avaSecondary = Color(0xFF48A388);
  static const Color avaSecondaryLight = Color(0xFFA9EACE);
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color disabled = Color(0xFFD8D5D9);
  static const Color gray = Color(0xFFD9D9D9);
  static const Color lightPurp = Color(0xFFA448FF);
  static const Color manilla = Color(0xFFF2F0ED);
  static const Color lightOrange = Color(0xFFFFD8B9);
  static const Color lightRed = Color(0xFFF5B8C3);

  // TODO: get error color from UX
  static const Color red = Colors.red;
  static const Color textLight = Color(0xFF736B7C);
  static const Color textGreen = Color(0xFF003928);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimaryDark = Color(0xFF2A1E39);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: avaPrimary,
    onPrimary: textWhite,
    secondary: avaSecondary,
    onSecondary: textWhite,
    error: red,
    onError: textWhite,
    onSurface: textPrimaryDark,
    surface: bgWhite,
    outline: gray,
  );
}
