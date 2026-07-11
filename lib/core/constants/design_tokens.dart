import 'package:flutter/material.dart';

class DesignTokens {
  DesignTokens._();

  // ---------------------------------------------------------------------------
  // Cores principais
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF1F7A4D);
  static const Color primaryDark = Color(0xFF123D2E);
  static const Color primaryStrong = Color(0xFF17613C);
  static const Color primaryLight = Color(0xFFEAF4EC);
  static const Color primarySoft = Color(0xFFF2F7F1);

  // ---------------------------------------------------------------------------
  // Fundos e superfícies
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFFF8F7F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFFBFCFA);
  static const Color surfaceMuted = Color(0xFFF1F4F0);
  static const Color surfaceHighlight = Color(0xFFF4F8F1);

  // ---------------------------------------------------------------------------
  // Texto
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFF17352D);
  static const Color textSecondary = Color(0xFF6F7E75);
  static const Color textMuted = Color(0xFF97A39B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Estados
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF1F7A4D);
  static const Color successBackground = Color(0xFFEDF6EF);

  static const Color warning = Color(0xFFB98224);
  static const Color warningBackground = Color(0xFFFFF5DF);

  static const Color danger = Color(0xFFB84A4A);
  static const Color dangerBackground = Color(0xFFFBECEC);

  static const Color neutral = Color(0xFF6F7E75);
  static const Color neutralBackground = Color(0xFFF0F2EF);

  // ---------------------------------------------------------------------------
  // Bordas e elementos inativos
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFFE4EAE6);
  static const Color borderSoft = Color(0xFFEDF0ED);
  static const Color disabled = Color(0xFFD7DED9);
  static const Color progressTrack = Color(0xFFE5ECE5);

  // ---------------------------------------------------------------------------
  // Navegação
  // ---------------------------------------------------------------------------

  static const Color navigationBackground = Color(0xFFFFFFFF);
  static const Color navigationActive = primary;
  static const Color navigationInactive = Color(0xFF626A65);

  // ---------------------------------------------------------------------------
  // Espaçamentos
  // ---------------------------------------------------------------------------

  static const double spacingXxs = 4;
  static const double spacingXs = 8;
  static const double spacingSm = 12;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2Xl = 40;
  static const double spacing3Xl = 56;
  static const double spacing4Xl = 64;

  // ---------------------------------------------------------------------------
  // Cantos
  // ---------------------------------------------------------------------------

  static const double radiusXs = 8;
  static const double radiusSm = 12;
  static const double radiusMd = 18;
  static const double radiusLg = 22;
  static const double radiusXl = 28;
  static const double radiusPill = 999;

  // ---------------------------------------------------------------------------
  // Medidas dos componentes
  // ---------------------------------------------------------------------------

  static const double buttonHeight = 58;
  static const double inputHeight = 64;

  static const double iconContainerSmall = 44;
  static const double iconContainerMedium = 52;
  static const double iconContainerLarge = 64;

  static const double bottomNavigationHeight = 88;
  static const double progressRingSize = 132;
  static const double progressRingStrokeWidth = 13;

  // ---------------------------------------------------------------------------
  // Animações
  // ---------------------------------------------------------------------------

  static const Duration animationFast = Duration(milliseconds: 180);
  static const Duration animationNormal = Duration(milliseconds: 350);
  static const Duration animationSlow = Duration(milliseconds: 900);

  static const Curve animationCurve = Curves.easeOutCubic;

  // ---------------------------------------------------------------------------
  // Sombras
  // ---------------------------------------------------------------------------

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF17352D).withValues(alpha: 0.045),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get cardShadowStrong => [
        BoxShadow(
          color: const Color(0xFF17352D).withValues(alpha: 0.075),
          blurRadius: 32,
          offset: const Offset(0, 14),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: primary.withValues(alpha: 0.20),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get navigationShadow => [
        BoxShadow(
          color: const Color(0xFF17352D).withValues(alpha: 0.07),
          blurRadius: 26,
          offset: const Offset(0, 8),
        ),
      ];
}