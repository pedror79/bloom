import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/formatters/financial_formatter.dart';

class ProjectionSummaryCard extends StatelessWidget {
  final double projectedPortfolio;
  final double fireNumber;
  final double progress;
  final bool onTrack;

  const ProjectionSummaryCard({
    super.key,
    required this.projectedPortfolio,
    required this.fireNumber,
    required this.progress,
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.borderSoft,
        ),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Património projetado',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                    const SizedBox(
                      height: DesignTokens.spacingXs,
                    ),
                    Text(
                      FinancialFormatter.compactCurrency(
                        projectedPortfolio,
                      ),
                      style: const TextStyle(
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.8,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              Container(
                width: DesignTokens.iconContainerMedium,
                height: DesignTokens.iconContainerMedium,
                decoration: BoxDecoration(
                  color: DesignTokens.primaryLight,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusMd,
                  ),
                ),
                child: const Icon(
                  Icons.show_chart_rounded,
                  size: 26,
                  color: DesignTokens.primary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusPill,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor:
                  DesignTokens.progressTrack,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                DesignTokens.primary,
              ),
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingSm,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FinancialFormatter.percentage(progress),
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.primary,
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              Expanded(
                child: Text(
                  'Objetivo: '
                  '${FinancialFormatter.compactCurrency(fireNumber)}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                    color: DesignTokens.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _ProjectionStatusBadge(
            onTrack: onTrack,
          ),
        ],
      ),
    );
  }
}

class _ProjectionStatusBadge extends StatelessWidget {
  final bool onTrack;

  const _ProjectionStatusBadge({
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: onTrack
            ? DesignTokens.primaryLight
            : DesignTokens.danger.withValues(
                alpha: 0.10,
              ),
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusPill,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            onTrack
                ? Icons.check_circle_outline_rounded
                : Icons.warning_amber_rounded,
            size: 17,
            color: onTrack
                ? DesignTokens.primary
                : DesignTokens.danger,
          ),
          const SizedBox(
            width: DesignTokens.spacingXs,
          ),
          Flexible(
            child: Text(
              onTrack
                  ? 'Projeção acima do objetivo'
                  : 'Projeção abaixo do objetivo',
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w700,
                color: onTrack
                    ? DesignTokens.primary
                    : DesignTokens.danger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}