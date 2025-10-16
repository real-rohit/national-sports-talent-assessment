import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryRed = Color(0xffe53935);
  static const Color darkRed = Color(0xff8a2322);
  static const Color orange = Color(0xffe38122);
  static const Color grayBackground = Color(0xfff6f6f6);
  static const Color cardBackground = Colors.white;

  static ThemeData theme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryRed,
        primary: primaryRed,
      ),
      scaffoldBackgroundColor: grayBackground,
      useMaterial3: true,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffe0e0e0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xffe0e0e0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryRed),
        ),
      ),
    );
  }
}


