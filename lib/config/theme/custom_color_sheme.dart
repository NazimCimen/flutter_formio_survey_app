import 'package:flutter/material.dart';

@immutable
final class CustomColorScheme {
  const CustomColorScheme._();
  static const lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff00C9FF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFE0E0E0),
    onSecondary: Color(0xFF000000),
    error: Color(0xFFB00020),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    tertiary: Colors.grey,
    tertiaryFixed: Colors.amberAccent,
    secondaryContainer: Colors.red,
    tertiaryContainer: Colors.green,
    onPrimaryContainer: Color.fromARGB(
      255,
      226,
      223,
      223,
    ),
    onTertiary: Color(0xFFFFFFFF),
    outline: Color(0xFFBDBDBD),
    scrim: Colors.black,
  );

  static const darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff00C9FF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF424242),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFCF6679),
    onError: Color(0xFF000000),
    surface: Color(0xFF303030),
    onSurface: Color(0xFFFFFFFF),
    tertiary: Colors.grey,
    tertiaryFixed: Colors.amberAccent,
    secondaryContainer: Colors.redAccent,
    tertiaryContainer: Colors.greenAccent,
    onPrimaryContainer: Color.fromARGB(95, 97, 97, 97),
    onTertiary: Color(0xFFFFFFFF),
    outline: Color(0xFF757575),
    scrim: Colors.black,
  );
}
