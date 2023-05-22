import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primary = Color(0xff605CFF);
const onPrimary = Color(0xffFFFFFF);
const secondary = Color(0xffFFCE51);
const onSecondary = Color(0xff000000);
const background = Color(0xffffffff);
const onBackground = Color(0xff303030);
const surface = Color(0xffe2ecf4);
const onSurface = Color(0xff111111);

const tagBackgroundColor = Color(0xffEDFBFE);
const tagTextColor = Color(0xff21C9EE);

final lightTheme = _lightThemeBuilder();

ThemeData _lightThemeBuilder() {
  final textTheme = GoogleFonts.robotoTextTheme().apply(
    bodyColor: onSurface,
    displayColor: onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
    ),
    textTheme: textTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(100, 62),
        backgroundColor: primary,
        foregroundColor: onPrimary,
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: Colors.black12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
      ),
    ),
  );
}

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(StadiumBorder()),
    ),
  ),
);
