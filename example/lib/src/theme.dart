import 'package:flutter/material.dart';

const primary = Color(0xffe56833);
const onPrimary = Color(0xff222430);
const secondary = Color(0xff1e5e5a);
const onSecondary = Color(0xffe2ecf4);
const background = Color(0xff303030);
const onBackground = Color(0xffe2ecf4);
const surface = Color(0xff424242);
const onSurface = Color(0xffe2ecf4);

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
