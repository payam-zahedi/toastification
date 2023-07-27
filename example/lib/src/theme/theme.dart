import 'package:flutter/material.dart';

const _primary = Color(0xff605CFF);
const _onPrimary = Color(0xffFFFFFF);
const _onPrimaryContainer = Color(0xff303030);
const _secondary = Color(0xffFFCE51);
const _onSecondary = Color(0xff000000);
const _background = Color(0xffffffff);
const _onBackground = Color(0xff000000);
const _surface = Color(0xffF4F6F8);
const _onSurface = Color(0xff111111);
const _error = Color(0xffFF5740);
const _onError = Color(0xffffffff);

// border color
const _outline = Color(0xffF2F2F2);

const _tagBackgroundColor = Color(0xffEDFBFE);
const _tagTextColor = Color(0xff21C9EE);

const _switchActiveColor = Color(0xff605CFF);
const _switchInActiveColor = Color(0xffC5CCD7);

const _cardColor = Color(0xffFAFAFA);
const _cardBorderColor = Color(0xffEBEBEB);

final lightTheme = _themeBuilder();

ThemeData _themeBuilder() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _primary,
    primary: _primary,
    onPrimary: _onPrimary,
    secondary: _secondary,
    onSecondary: _onSecondary,
    tertiary: _tagBackgroundColor,
    onTertiary: _tagTextColor,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
    surfaceVariant: _cardColor,
    onSurfaceVariant: _cardBorderColor,
    onPrimaryContainer: _onPrimaryContainer,
    error: _error,
    onError: _onError,
    outline: _outline,
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
    disabledColor: _switchInActiveColor,
    focusColor: _switchActiveColor,
    textTheme: textTheme,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(100, 48),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(width: 1, color: Colors.black12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(100, 48),
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(100, 48),
        backgroundColor: scheme.background,
        foregroundColor: scheme.onBackground,
        textStyle: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        side: BorderSide(
          width: 1,
          color: scheme.onBackground.withOpacity(.1),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: scheme.onPrimaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        maximumSize: const Size(36, 36),
        minimumSize: const Size(36, 36),
        padding: const EdgeInsets.all(0),
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
    cardTheme: CardTheme(
      color: scheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: scheme.onSurfaceVariant,
          width: 1,
        ),
      ),
      elevation: 0,
      margin: EdgeInsets.zero,
    ),
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
