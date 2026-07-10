import 'package:flutter/material.dart';
import '../constants/design_tokens.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = DesignTokens.primary;
  static const Color background = DesignTokens.background;
  static const Color textPrimary = DesignTokens.textPrimary;
  static const Color textSecondary = DesignTokens.textSecondary;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: DesignTokens.primary,
      brightness: Brightness.light,
      surface: DesignTokens.surface,
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: DesignTokens.background,
      colorScheme: colorScheme,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 40,
          height: 1.08,
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
          color: DesignTokens.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 34,
          height: 1.1,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
          color: DesignTokens.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: DesignTokens.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: DesignTokens.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          height: 1.4,
          color: DesignTokens.textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          height: 1.4,
          color: DesignTokens.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          height: 1.35,
          color: DesignTokens.textSecondary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        hintStyle: const TextStyle(
          color: DesignTokens.textSecondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            DesignTokens.radiusMd,
          ),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            DesignTokens.radiusMd,
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            DesignTokens.radiusMd,
          ),
          borderSide: const BorderSide(
            color: DesignTokens.primary,
            width: 1.4,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            DesignTokens.buttonHeight,
          ),
          backgroundColor: DesignTokens.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: DesignTokens.disabled,
          disabledForegroundColor: Colors.white70,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusMd,
            ),
          ),
        ),
      ),
    );
  }
}