import 'package:flutter/material.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

export 'app_colors.dart';

/// Central access point for the app's [ThemeData] instances.
class AppTheme {
  AppTheme._();

  static final ThemeData light = buildLightTheme();
  static final ThemeData dark = buildDarkTheme();
}
