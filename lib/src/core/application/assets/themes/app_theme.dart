import 'package:flutter/material.dart';

enum AppTheme { light, dark }

abstract class AppThemeData {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );

  /// just example
  static final dark = light.copyWith(brightness: Brightness.dark);
}
