import 'package:flutter/material.dart';

class DesignTokens {
  DesignTokens._();

  // Cores
  static const Color primary = Color(0xFF1F7A4D);
  static const Color primaryDark = Color(0xFF17352D);
  static const Color primaryLight = Color(0xFFE9F5EF);

  static const Color background = Color(0xFFF8F7F2);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF17352D);
  static const Color textSecondary = Color(0xFF6F7E75);

  static const Color border = Color(0xFFE4EAE6);
  static const Color disabled = Color(0xFFD7DED9);

  // Espaçamentos
  static const double spacingXs = 8;
  static const double spacingSm = 16;
  static const double spacingMd = 24;
  static const double spacingLg = 40;
  static const double spacingXl = 64;

  // Cantos
  static const double radiusSm = 12;
  static const double radiusMd = 18;
  static const double radiusLg = 22;
  static const double radiusXl = 28;

  // Alturas
  static const double buttonHeight = 58;
  static const double inputHeight = 64;

  // Animações
  static const Duration animationFast = Duration(milliseconds: 180);
  static const Duration animationNormal = Duration(milliseconds: 350);
  static const Duration animationSlow = Duration(milliseconds: 900);

  // Sombras
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ];
}