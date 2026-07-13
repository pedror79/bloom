import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/formatters/financial_formatter.dart';

class RequiredInvestmentCard extends StatelessWidget {
  final double currentMonthlyInvestment;
  final double requiredMonthlyInvestment;
  final bool onTrack;

  const RequiredInvestmentCard({
    super.key,
    required this.currentMonthlyInvestment,
    required this.requiredMonthlyInvestment,
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    final double monthlyDifference =
        currentMonthlyInvestment - requiredMonthlyInvestment;

    final double displayedDifference = monthlyDifference.abs();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      ? Icons.savings_outlined
                      : Icons.trending_up_rounded,
                  size: 25,
                  color: onTrack
                      ? DesignTokens.primary
                      : DesignTokens.danger,
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Investimento mensal necessário',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    SizedBox(
                      height: DesignTokens.spacingXxs,
                    ),
                    Text(
                      'Valor estimado para atingires o objetivo na idade definida.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          Text(
            FinancialFormatter.compactCurrency(
              requiredMonthlyInvestment,
            ),
            style: TextStyle(
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: onTrack
                  ? DesignTokens.primary
                  : DesignTokens.danger,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(
              DesignTokens.spacingMd,
            ),
            decoration: BoxDecoration(
              color: DesignTokens.surface,
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  onTrack
                      ? Icons.check_circle_outline_rounded
                      : Icons.info_outline_rounded,
                  size: 20,
                  color: onTrack
                      ? DesignTokens.primary
                      : DesignTokens.danger,
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                Expanded(
                  child: Text(
                    onTrack
                        ? 'Investes atualmente '
                            '${FinancialFormatter.compactCurrency(displayedDifference)} '
                            'acima do valor mensal necessário.'
                        : 'Precisarias de investir mais '
                            '${FinancialFormatter.compactCurrency(displayedDifference)} '
                            'por mês para atingires o objetivo.',
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      fontWeight: FontWeight.w600,
                      color: DesignTokens.textPrimary,
                    ),
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