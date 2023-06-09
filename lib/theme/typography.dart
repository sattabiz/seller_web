import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/theme/theme_colors.dart';


final themeText = TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      height: 1,
      letterSpacing: -0.25,
      color: themeColor.onSurface,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      height: 1.16,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      height: 1.22,
      letterSpacing: 0,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      height: 1.1,
      letterSpacing: 0,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 1.16,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 1.22,
      color: themeColor.onSurfaceVariant,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      height: 1.1,
      letterSpacing: 0,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.15,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.14,
      letterSpacing: 0.5,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.16,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.16,
      letterSpacing: 0.4,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 1.45,
      letterSpacing: 0.5,
    ),
);
