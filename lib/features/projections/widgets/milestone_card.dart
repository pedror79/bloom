import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/formatters/financial_formatter.dart';

class MilestoneCard extends StatelessWidget {
  final int targetAge;
  final int targetYear;
  final double projectedPortfolio;

  const MilestoneCard({
    super.key,
    required this.targetAge,
    required this.targetYear,
    required this.projectedPortfolio,
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
          const Text(
            'Marco do plano',
            style: TextStyle(
              fontSize: 18,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: DesignTokens.primaryLight,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusMd,
                  ),
                ),
                child: const Icon(
                  Icons.emoji_events_outlined,
                  size: 27,
                  color: DesignTokens.primary,
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              Expanded(
                child: Text(
                  'Em $targetYear, aos $targetAge anos, '
                  'o património projetado é de '
                  '${FinancialFormatter.compactCurrency(projectedPortfolio)}.',
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: DesignTokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}