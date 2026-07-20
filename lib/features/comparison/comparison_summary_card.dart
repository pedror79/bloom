import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';

class ComparisonSummaryCard extends StatelessWidget {
  final double officialProjectedPortfolio;
  final double simulatedProjectedPortfolio;

  final int officialTargetAge;
  final int simulatedTargetAge;

  final double officialMonthlyInvestment;
  final double simulatedMonthlyInvestment;

  final double portfolioDifference;
  final double monthlyInvestmentDifference;
  final double dailyInvestmentDifference;

  final int freedomYearsGained;

  const ComparisonSummaryCard({
    super.key,
    required this.officialProjectedPortfolio,
    required this.simulatedProjectedPortfolio,
    required this.officialTargetAge,
    required this.simulatedTargetAge,
    required this.officialMonthlyInvestment,
    required this.simulatedMonthlyInvestment,
    required this.portfolioDifference,
    required this.monthlyInvestmentDifference,
    required this.dailyInvestmentDifference,
    required this.freedomYearsGained,
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
          const Row(
            children: [
              Icon(
                Icons.insights_outlined,
                size: 24,
                color: DesignTokens.primary,
              ),
              SizedBox(
                width: DesignTokens.spacingSm,
              ),
              Expanded(
                child: Text(
                  'Resumo da decisão',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingXs,
          ),
          const Text(
            'Compara rapidamente os principais resultados dos dois planos.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          const _ScenarioHeader(),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _SummaryComparisonRow(
            icon: Icons.trending_up_rounded,
            label: 'Património projetado',
            officialValue: _formatCurrency(
              officialProjectedPortfolio,
            ),
            simulatedValue: _formatCurrency(
              simulatedProjectedPortfolio,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _DifferenceHighlight(
            label: 'Diferença de património',
            value: _formatSignedCurrency(
              portfolioDifference,
            ),
            positive: portfolioDifference > 0,
            neutral: portfolioDifference == 0,
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          _SummaryComparisonRow(
            icon: Icons.flag_outlined,
            label: 'Idade objetivo',
            officialValue: '$officialTargetAge anos',
            simulatedValue: '$simulatedTargetAge anos',
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _DifferenceHighlight(
            label: 'Liberdade financeira',
            value: _formatFreedomDifference(
              freedomYearsGained,
            ),
            positive: freedomYearsGained > 0,
            neutral: freedomYearsGained == 0,
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          _SummaryComparisonRow(
            icon: Icons.savings_outlined,
            label: 'Investimento mensal',
            officialValue: _formatCurrency(
              officialMonthlyInvestment,
            ),
            simulatedValue: _formatCurrency(
              simulatedMonthlyInvestment,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          _InvestmentDifferenceCard(
            monthlyDifference:
                monthlyInvestmentDifference,
            dailyDifference:
                dailyInvestmentDifference,
          ),
        ],
      ),
    );
  }

  static String _formatCurrency(double value) {
    final String digits =
        value.abs().toStringAsFixed(0);

    final String formattedDigits =
        digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => '.',
    );

    final String sign = value < 0 ? '-' : '';

    return '$sign$formattedDigits €';
  }

  static String _formatSignedCurrency(double value) {
    if (value == 0) {
      return 'Sem diferença';
    }

    final String sign = value > 0 ? '+' : '-';

    return '$sign${_formatCurrency(value.abs())}';
  }

  static String _formatFreedomDifference(
    int freedomYearsGained,
  ) {
    if (freedomYearsGained == 0) {
      return 'Mesma idade objetivo';
    }

    final int years = freedomYearsGained.abs();
    final String unit = years == 1 ? 'ano' : 'anos';

    if (freedomYearsGained > 0) {
      return '+$years $unit de liberdade';
    }

    return '-$years $unit de liberdade';
  }
}

class _ScenarioHeader extends StatelessWidget {
  const _ScenarioHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 5,
          child: SizedBox.shrink(),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Plano Oficial',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color: DesignTokens.textSecondary,
            ),
          ),
        ),
        SizedBox(
          width: DesignTokens.spacingSm,
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Simulado',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryComparisonRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String officialValue;
  final String simulatedValue;

  const _SummaryComparisonRow({
    required this.icon,
    required this.label,
    required this.officialValue,
    required this.simulatedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DesignTokens.primaryLight,
                  borderRadius: BorderRadius.circular(
                    DesignTokens.radiusSm,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: DesignTokens.primary,
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingSm,
              ),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: DesignTokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            officialValue,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
        ),
        const SizedBox(
          width: DesignTokens.spacingSm,
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingXs,
              vertical: DesignTokens.spacingSm,
            ),
            decoration: BoxDecoration(
              color: DesignTokens.primaryLight,
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Text(
              simulatedValue,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: DesignTokens.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DifferenceHighlight extends StatelessWidget {
  final String label;
  final String value;
  final bool positive;
  final bool neutral;

  const _DifferenceHighlight({
    required this.label,
    required this.value,
    required this.positive,
    required this.neutral,
  });

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor;

    if (neutral) {
      foregroundColor = DesignTokens.textSecondary;
    } else if (positive) {
      foregroundColor = DesignTokens.primary;
    } else {
      foregroundColor = DesignTokens.textSecondary;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingMd,
        vertical: DesignTokens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: foregroundColor.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                height: 1.2,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textSecondary,
              ),
            ),
          ),
          const SizedBox(
            width: DesignTokens.spacingSm,
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InvestmentDifferenceCard extends StatelessWidget {
  final double monthlyDifference;
  final double dailyDifference;

  const _InvestmentDifferenceCard({
    required this.monthlyDifference,
    required this.dailyDifference,
  });

  @override
  Widget build(BuildContext context) {
    final bool neutral = monthlyDifference == 0;
    final bool positive = monthlyDifference > 0;

    final Color foregroundColor = neutral
        ? DesignTokens.textSecondary
        : positive
            ? DesignTokens.primary
            : DesignTokens.textSecondary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: foregroundColor.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
      ),
      child: neutral
          ? const Text(
              'O investimento mensal é igual nos dois planos.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: DesignTokens.textSecondary,
              ),
            )
          : Row(
              children: [
                Expanded(
                  child: _InvestmentDifferenceMetric(
                    label: 'Por mês',
                    value: _formatSignedCurrency(
                      monthlyDifference,
                      decimals: 0,
                    ),
                    color: foregroundColor,
                  ),
                ),
                Container(
                  width: 1,
                  height: 38,
                  margin: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                  ),
                  color: DesignTokens.borderSoft,
                ),
                Expanded(
                  child: _InvestmentDifferenceMetric(
                    label: 'Por dia',
                    value: _formatSignedCurrency(
                      dailyDifference,
                      decimals: 2,
                    ),
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
    );
  }

  static String _formatSignedCurrency(
    double value, {
    required int decimals,
  }) {
    final String sign = value >= 0 ? '+' : '-';

    return '$sign'
        '${value.abs().toStringAsFixed(decimals)} €';
  }
}

class _InvestmentDifferenceMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InvestmentDifferenceMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: DesignTokens.textSecondary,
          ),
        ),
        const SizedBox(
          height: DesignTokens.spacingXs,
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}