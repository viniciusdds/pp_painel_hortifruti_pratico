import 'package:flutter/material.dart';

var colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.greenAccent
);

var radioTheme = RadioThemeData(
  fillColor: MaterialStateColor.resolveWith((states) => colorScheme.primary),
);

var elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    foregroundColor: colorScheme.onPrimary,
    backgroundColor: colorScheme.primary
  )
);

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  radioTheme: radioTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  useMaterial3: true
);