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
  textTheme: GoogleFonts.mavenProTextTheme(),
  fontFamily: FontFamily.marven,
  brightness: Brightness.dark,
  primaryColor: AppColors.orange[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.orange[500],
  accentColorBrightness: Brightness.dark,
);

final ThemeData themeDataLight = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.marvel(fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold),
    headline2: GoogleFonts.marvel(fontSize: 30),
    headline3: GoogleFonts.marvel(fontSize: 26),
    headline4: GoogleFonts.marvel(fontSize: 20),
    headline5: GoogleFonts.marvel(fontSize: 18),
    headline6: GoogleFonts.marvel(fontSize: 16),
    subtitle1: GoogleFonts.marvel(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),

  ).apply(
    bodyColor: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.amber,
    size: 20,
  ),
  primaryColor: Colors.amber,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.white,
  accentColorBrightness: Brightness.light,

  appBarTheme: AppBarTheme(
    brightness: Brightness.light,
    color: Colors.white,
    centerTitle: true,
  ),
  brightness: Brightness.light,

);