import 'package:flutter/material.dart';

const _primary = Color(0xff605CFF);
const _onPrimary = Color(0xffFFFFFF);
const _secondary = Color(0xffFFCE51);
const _onSecondary = Color(0xff000000);
const _background = Color(0xffffffff);
const _onBackground = Color(0xff303030);
const _surface = Color(0xffe2ecf4);
const _onSurface = Color(0xff111111);
const _error = Color(0xffFF5740);
const _onError = Color(0xffffffff);

// border color
const _outline = Color(0xffF2F2F2);

const _tagBackgroundColor = Color(0xffEDFBFE);
const _tagTextColor = Color(0xff21C9EE);

const _switchActiveColor = Color(0xff605CFF);
const _switchInActiveColor = Color(0xffC5CCD7);

final lightTheme = _themeBuilder();

ThemeData _themeBuilder() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _primary,
    primary: _primary,
    onPrimary: _onPrimary,
    secondary: _secondary,
    onSecondary: _onSecondary,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
    error: _error,
    onError: _onError,
    outline: _outline,
    surfaceVariant: _tagBackgroundColor,
    onSurfaceVariant: _tagTextColor,
  );

  final textTheme = ThemeData.light(useMaterial3: true).textTheme.apply(
        fontFamily: 'PlusJakartaDisplay',
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: scheme,
    dividerColor: scheme.outline,
    textTheme: textTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(100, 62),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 1, color: Colors.black12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurface.withOpacity(.5),
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1),
      ),
    ),
    disabledColor: _switchInActiveColor,
    focusColor: _switchActiveColor,
  );
}

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: _primary,
    onPrimary: _onPrimary,
    secondary: _secondary,
    onSecondary: _onSecondary,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(StadiumBorder()),
    ),
  ),
);
