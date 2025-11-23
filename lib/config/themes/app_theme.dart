import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF51AFA9);
  static const Color primaryLight = Color(0xFF8FD7D2);
  static const Color primaryDark = Color(0xFF3C837D);
  static const Color titleTextColor = Color(0xFF1A1A1A);
  static Color labelTextColor = Colors.grey[600]!;

  static final ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: primaryDark,
    ),
    useMaterial3: true,
    // Optional: For modern look
    scaffoldBackgroundColor: const Color(0xFFFFFDFC),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    textTheme: GoogleFonts.jostTextTheme().copyWith(
      headlineLarge: GoogleFonts.jost(color: titleTextColor),
      headlineMedium: GoogleFonts.jost(color: titleTextColor),
      headlineSmall: GoogleFonts.jost(color: titleTextColor),
      titleLarge: GoogleFonts.jost(color: titleTextColor),
      titleMedium: GoogleFonts.jost(color: titleTextColor),
      titleSmall: GoogleFonts.jost(color: titleTextColor),
      bodyLarge: GoogleFonts.jost(color: titleTextColor),
      bodyMedium: GoogleFonts.jost(color: titleTextColor),
      bodySmall: GoogleFonts.jost(color: labelTextColor),
      labelLarge: GoogleFonts.jost(color: labelTextColor),
      labelMedium: GoogleFonts.jost(color: labelTextColor),
      labelSmall: GoogleFonts.jost(color: labelTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: const .symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: .circular(12)),
        textStyle: const TextStyle(fontWeight: .bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      prefixIconColor: primary,
      border: OutlineInputBorder(borderRadius: .circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primary),
        borderRadius: .circular(12),
      ),
      labelStyle: const TextStyle(color: primary),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primary,
      contentTextStyle: TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
