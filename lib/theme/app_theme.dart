// THEME LOCK: light — source: domain signal (professional teacher tool, classroom use)
// Scaffold.backgroundColor = AppTheme.background — ALL screens

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary palette
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryContainer = Color(0xFFEDE9FF);
  static const Color secondary = Color(0xFFFDCB6E);
  static const Color secondaryContainer = Color(0xFFFFF3CD);

  // Semantic colors
  static const Color success = Color(0xFF00B894);
  static const Color successContainer = Color(0xFFD4F5EC);
  static const Color warning = Color(0xFFE17055);
  static const Color warningContainer = Color(0xFFFFEBE6);
  static const Color error = Color(0xFFD63031);
  static const Color errorContainer = Color(0xFFFFE5E5);

  // VAK colors
  static const Color vakVisual = Color(0xFF74B9FF);
  static const Color vakAuditory = Color(0xFFA29BFE);
  static const Color vakKinesthetic = Color(0xFF55EFC4);

  // Light surfaces
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF5F3FF);
  static const Color backgroundLight = Color(0xFFF8F7FF);

  // Dark surfaces
  static const Color surfaceDark = Color(0xFF1E1C2E);
  static const Color surfaceVariantDark = Color(0xFF2D2A45);
  static const Color backgroundDark = Color(0xFF13111F);

  // Card accent colors (for class cards)
  static const Color cardAccent1 = Color(0xFFE8F4FD);
  static const Color cardAccent2 = Color(0xFFF3F0FF);
  static const Color cardAccent3 = Color(0xFFFFF8E7);
  static const Color cardAccent4 = Color(0xFFE8FDF5);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: Color(0xFF2D1B8E),
      secondary: secondary,
      onSecondary: Color(0xFF3D2C00),
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: Color(0xFF3D2C00),
      surface: surfaceLight,
      onSurface: Color(0xFF1A1A2E),
      surfaceContainerHighest: surfaceVariantLight,
      onSurfaceVariant: Color(0xFF4A4560),
      error: error,
      onError: Colors.white,
      outline: Color(0xFFD0CCF0),
      outlineVariant: Color(0xFFEDE9FF),
    ),
    scaffoldBackgroundColor: backgroundLight,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A2E),
      ),
    ),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: surfaceVariantLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFD0CCF0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 1),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: TextStyle(color: Color(0xFF4A4560)),
      floatingLabelStyle: TextStyle(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceVariantLight,
      selectedColor: primaryContainer,
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide.none,
    ),
    dividerTheme: DividerThemeData(
      color: Color(0xFFEDE9FF),
      thickness: 1,
      space: 1,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF9D8FF5),
      onPrimary: Color(0xFF1A1A2E),
      primaryContainer: Color(0xFF3D2F8E),
      onPrimaryContainer: Color(0xFFEDE9FF),
      secondary: secondary,
      onSecondary: Color(0xFF3D2C00),
      surface: surfaceDark,
      onSurface: Color(0xFFE8E6F8),
      surfaceContainerHighest: surfaceVariantDark,
      onSurfaceVariant: Color(0xFFB0ABCC),
      error: Color(0xFFFF6B6B),
      onError: Color(0xFF1A1A2E),
      outline: Color(0xFF4A4560),
      outlineVariant: Color(0xFF2D2A45),
    ),
    scaffoldBackgroundColor: backgroundDark,
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE8E6F8),
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE8E6F8),
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFE8E6F8),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFFB0ABCC),
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFFB0ABCC),
        ),
      ),
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: backgroundDark,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
