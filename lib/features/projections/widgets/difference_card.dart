import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/formatters/financial_formatter.dart';

class DifferenceCard extends StatelessWidget {
  final bool onTrack;
  final double difference;
  final double remainingPortfolio;
  final int targetAge;

  const DifferenceCard({
    super.key,
    required this.onTrack,
    required this.difference,
    required this.remainingPortfolio,
    required this.targetAge,
  });

  @override
  Widget build(BuildContext context) {
    final double displayedValue =
        onTrack ? difference : remainingPortfolio;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: onTrack
            ? DesignTokens.primaryLight
            : DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: onTrack
              ? DesignTokens.primary.withValues(
                  alpha: 0.20,
                )
              : DesignTokens.borderSoft,
        ),
        boxShadow: onTrack
            ? const []
            : DesignTokens.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: DesignTokens.iconContainerMedium,
            height: DesignTokens.iconContainerMedium,
            decoration: BoxDecoration(
              color: DesignTokens.surface,
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Icon(
              onTrack
                  ? Icons.check_circle_outline_rounded
                  : Icons.track_changes_rounded,
              size: 25,
              color: onTrack
                  ? DesignTokens.primary
                  : DesignTokens.danger,
            ),
          ),
          const SizedBox(
            width: DesignTokens.spacingMd,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  onTrack
                      ? 'Margem projetada'
                      : 'Capital em falta',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(
                  height: DesignTokens.spacingXs,
                ),
                Text(
                  FinancialFormatter.compactCurrency(
                    displayedValue,
                  ),
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: onTrack
                        ? DesignTokens.primary
                        : DesignTokens.danger,
                  ),
                ),
                const SizedBox(
                  height: DesignTokens.spacingXs,
                ),
                Text(
                  onTrack
                      ? 'Mantendo o plano atual, esta é a margem estimada aos $targetAge anos.'
                      : 'Este é o valor adicional necessário para atingires o objetivo aos $targetAge anos.',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}