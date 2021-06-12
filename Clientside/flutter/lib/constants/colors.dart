import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const Map<int, Color> orange = const <int, Color>{
    50: const Color(0xFFFCF2E7),
    100: const Color(0xFFF8DEC3),
    200: const Color(0xFFF3C89C),
    300: const Color(0xFFEEB274),
    400: const Color(0xFFEAA256),
    500: const Color(0xFFE69138),
    600: const Color(0xFFE38932),
    700: const Color(0xFFDF7E2B),
    800: const Color(0xFFDB7424),
    900: const Color(0xFFD56217)
  };

  static const Color lightDarkThemeColor = const Color.fromRGBO(30, 32, 38, 1);
  static const Color backgroundDarkThemeColor = const Color.fromRGBO(18, 22, 28, 1);
  static const Color greyForCardLightTheme = const Color.fromRGBO(238, 238, 238, 1);
  static const Color darkBlueForCardDarkTheme = const Color.fromRGBO(30, 32, 38, 1);

}
