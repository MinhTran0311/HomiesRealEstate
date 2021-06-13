import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/font_family.dart';
/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = new ThemeData(
    textTheme: GoogleFonts.mavenProTextTheme(),
    fontFamily: FontFamily.marven,
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.orange[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.orange[500],
    accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  textTheme: GoogleFonts.mavenProTextTheme(
  ).apply(
    bodyColor: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.amber,
    size: 24,

  ),

  disabledColor: Colors.amber,

  primaryColor: Colors.black,
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.amber,
  accentColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Color.fromRGBO(18, 22, 28, 1),
  brightness: Brightness.dark,

  appBarTheme: AppBarTheme(

      brightness: Brightness.dark,
      color: Colors.amber,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 20,
      )
  ),
);

final ThemeData themeDataLight = ThemeData(
  textTheme: GoogleFonts.mavenProTextTheme(
  ).apply(
    bodyColor: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.amber,
    size: 20,
  ),
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.amber,
  accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textSelectionColor: Colors.blueAccent,

  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    color: Colors.amber,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20,
    ),
  ),

  brightness: Brightness.light,
);