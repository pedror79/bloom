import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import '../../../core/formatters/financial_formatter.dart';
import '../../../models/user_profile.dart';

class SimulationControlsCard extends StatelessWidget {
  final UserProfile profile;
  final int minimumTargetAge;
  final ValueChanged<double> onCurrentPortfolioChanged;
  final ValueChanged<double> onMonthlyInvestmentChanged;
  final ValueChanged<double>
      onDesiredMonthlyIncomeChanged;
  final ValueChanged<double> onTargetAgeChanged;
  final VoidCallback onReset;

  const SimulationControlsCard({
    super.key,
    required this.profile,
    required this.minimumTargetAge,
    required this.onCurrentPortfolioChanged,
    required this.onMonthlyInvestmentChanged,
    required this.onDesiredMonthlyIncomeChanged,
    required this.onTargetAgeChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final double currentPortfolio =
        (profile.currentPortfolio ?? 0.0)
            .clamp(0.0, 1000000.0)
            .toDouble();

    final double monthlyInvestment =
        (profile.monthlyInvestment ?? 0.0)
            .clamp(0.0, 5000.0)
            .toDouble();

    final double desiredMonthlyIncome =
        (profile.desiredMonthlyIncomeToday ?? 0.0)
            .clamp(500.0, 10000.0)
            .toDouble();

    final double maximumTargetAge =
        math.max(minimumTargetAge + 1, 75).toDouble();

    final double targetAge =
        (profile.targetFinancialIndependenceAge ??
                minimumTargetAge)
            .toDouble()
            .clamp(
              minimumTargetAge.toDouble(),
              maximumTargetAge,
            )
            .toDouble();

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
            children: [
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
                  Icons.tune_rounded,
                  size: 24,
                  color: DesignTokens.primary,
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
                      'Simulador',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    SizedBox(
                      height: DesignTokens.spacingXxs,
                    ),
                    Text(
                      'Os resultados atualizam em tempo real.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onReset,
                tooltip: 'Repor valores',
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          _SimulationSlider(
            label: 'Património atual',
            valueLabel:
                FinancialFormatter.compactCurrency(
              currentPortfolio,
            ),
            value: currentPortfolio,
            minimum: 0.0,
            maximum: 1000000.0,
            divisions: 200,
            onChanged: onCurrentPortfolioChanged,
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _SimulationSlider(
            label: 'Investimento mensal',
            valueLabel:
                FinancialFormatter.compactCurrency(
              monthlyInvestment,
            ),
            value: monthlyInvestment,
            minimum: 0.0,
            maximum: 5000.0,
            divisions: 100,
            onChanged: onMonthlyInvestmentChanged,
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _SimulationSlider(
            label: 'Rendimento mensal desejado',
            valueLabel:
                FinancialFormatter.compactCurrency(
              desiredMonthlyIncome,
            ),
            value: desiredMonthlyIncome,
            minimum: 500.0,
            maximum: 10000.0,
            divisions: 95,
            onChanged: onDesiredMonthlyIncomeChanged,
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _SimulationSlider(
            label: 'Idade objetivo',
            valueLabel: '${targetAge.round()} anos',
            value: targetAge,
            minimum: minimumTargetAge.toDouble(),
            maximum: maximumTargetAge,
            divisions:
                maximumTargetAge.round() - minimumTargetAge,
            onChanged: onTargetAgeChanged,
          ),
        ],
      ),
    );
  }
}

class _SimulationSlider extends StatelessWidget {
  final String label;
  final String valueLabel;
  final double value;
  final double minimum;
  final double maximum;
  final int divisions;
  final ValueChanged<double> onChanged;

  const _SimulationSlider({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ),
            const SizedBox(
              width: DesignTokens.spacingMd,
            ),
            Text(
              valueLabel,
              style: const TextStyle(
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w700,
                color: DesignTokens.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: DesignTokens.spacingXs,
        ),
        Slider(
          value: value,
          min: minimum,
          max: maximum,
          divisions: divisions,
          label: valueLabel,
          activeColor: DesignTokens.primary,
          inactiveColor: DesignTokens.progressTrack,
          onChanged: onChanged,
        ),
      ],
    );
  }
}