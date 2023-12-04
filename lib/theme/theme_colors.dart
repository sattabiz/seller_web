import 'package:flutter/material.dart';

class ThemeColor {  // abstrac class olmali ?
  static const Color primaryColor = Color(0xFFEC692C);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFDBCE);
  static const Color onPrimaryContainer = Color(0xFF370E00);
  static const Color secondary = Color(0xFF006B57);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFCED6D0);
  static const Color onSecondaryContainer = Color(0xFF002019);
  static const Color tertiary = Color(0xFF416277);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFC5E7FF);
  static const Color onTertiaryContainer = Color(0xFF001E2D);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);
  static const Color outline = Color(0xFF6F7975);
  static const Color background = Color(0xFFFBFDFA);
  static const Color onBackground = Color(0xFF191C1B);
  static const Color surface = Color(0xFFF3F5F3);
  static const Color onSurface = Color(0xFF191C1B);
  static const Color surfaceVariant = Color(0xFFE1E3E0);
  static const Color onSurfaceVariant = Color(0xFF3F4945);
  static const Color inverseSurface = Color(0xFF2E312F);
  static const Color onInverseSurface = Color(0xFFEFF1EE);
  static const Color inversePrimary = Color(0xFF74CAB4);
  static const Color shadow = Color(0xFF000000);
  static const Color surfaceTint = Color(0xFF006B57);
  static const Color outlineVariant = Color(0xFFBFC9C4);
  static const Color scrim = Color(0xFF000000);
}
const  themeColor =  ColorScheme(
  brightness: Brightness.light,
  primary: ThemeColor.primaryColor,
  onPrimary: ThemeColor.onPrimary,
  primaryContainer: ThemeColor.primaryContainer,
  onPrimaryContainer: ThemeColor.onPrimaryContainer,
  secondary: ThemeColor.secondary,
  onSecondary: ThemeColor.onSecondary,
  secondaryContainer: ThemeColor.secondaryContainer,
  onSecondaryContainer: ThemeColor.onSecondaryContainer,
  tertiary: ThemeColor.tertiary,
  onTertiary: ThemeColor.onTertiary,
  tertiaryContainer: ThemeColor.tertiaryContainer,
  onTertiaryContainer: ThemeColor.onTertiaryContainer,
  error: ThemeColor.error,
  onError: ThemeColor.onError,
  errorContainer: ThemeColor.errorContainer,
  onErrorContainer: ThemeColor.onErrorContainer,
  outline: ThemeColor.outline,
  background: ThemeColor.background,
  onBackground: ThemeColor.onBackground,
  surface: ThemeColor.surface,
  onSurface: ThemeColor.onSurface,
  surfaceVariant: ThemeColor.surfaceVariant,
  onSurfaceVariant: ThemeColor.onSurfaceVariant,
  inverseSurface: ThemeColor.inverseSurface,
  onInverseSurface: ThemeColor.onInverseSurface,
  inversePrimary: ThemeColor.inversePrimary,
  shadow: ThemeColor.shadow,
  surfaceTint: ThemeColor.surfaceTint,
  outlineVariant: ThemeColor.outlineVariant,
  scrim: ThemeColor.scrim,
);