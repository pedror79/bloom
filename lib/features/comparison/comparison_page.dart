import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../models/simulation_scenario.dart';
import '../../models/user_profile.dart';
import 'comparison_view_model.dart';

class ComparisonPage extends StatelessWidget {
  final UserProfile profile;
  final SimulationScenario scenario;

  const ComparisonPage({
    super.key,
    required this.profile,
    required this.scenario,
  });

  @override
  Widget build(BuildContext context) {
    final ComparisonViewModel viewModel =
        ComparisonViewModel.from(
      profile: profile,
      scenario: scenario,
    );

    final double officialMonthlyInvestment =
        (viewModel.officialProfile.monthlyInvestment ?? 0)
            .toDouble();

    final double simulatedMonthlyInvestment =
        (viewModel.simulatedProfile.monthlyInvestment ?? 0)
            .toDouble();

    final int officialTargetAge =
        viewModel.official.targetAge;

    final int simulatedTargetAge =
        viewModel.simulated.targetAge;

    final int officialYearsRemaining =
        viewModel.official.yearsRemaining;

    final int simulatedYearsRemaining =
        viewModel.simulated.yearsRemaining;

    final double officialProjectedPortfolio =
        viewModel.official.projectedPortfolio.toDouble();

    final double simulatedProjectedPortfolio =
        viewModel.simulated.projectedPortfolio.toDouble();

    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            DesignTokens.spacingLg,
            DesignTokens.spacingLg,
            DesignTokens.spacingLg,
            DesignTokens.spacing3Xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BloomHeader(),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              const Text(
                'Comparar',
                style: TextStyle(
                  fontSize: 34,
                  height: 1.08,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.9,
                  color: DesignTokens.textPrimary,
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingXs,
              ),
              const Text(
                'Percebe o impacto das alterações feitas no Simulador.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                  color: DesignTokens.textSecondary,
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              const _ScenarioLabels(),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _ComparisonCard(
                icon: Icons.savings_outlined,
                title: 'Investimento mensal',
                officialValue: _formatCurrency(
                  officialMonthlyInvestment,
                ),
                simulatedValue: _formatCurrency(
                  simulatedMonthlyInvestment,
                ),
                differenceText: _formatCurrencyDifference(
                  viewModel.monthlyInvestmentDifference,
                  suffix: ' / mês',
                ),
                differenceType: _differenceType(
                  viewModel.monthlyInvestmentDifference,
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _DecisionCostCard(
                monthlyDifference:
                    viewModel.monthlyInvestmentDifference,
                dailyDifference:
                    viewModel.dailyInvestmentDifference,
                yearlyDifference:
                    viewModel.yearlyInvestmentDifference,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _ComparisonCard(
                icon: Icons.flag_outlined,
                title: 'Idade objetivo',
                officialValue: '$officialTargetAge anos',
                simulatedValue: '$simulatedTargetAge anos',
                differenceText: _formatFreedomDifference(
                  viewModel.freedomYearsGained,
                ),
                differenceType: _differenceType(
                  viewModel.freedomYearsGained.toDouble(),
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _ComparisonCard(
                icon: Icons.schedule_outlined,
                title: 'Horizonte',
                officialValue:
                    '$officialYearsRemaining anos',
                simulatedValue:
                    '$simulatedYearsRemaining anos',
                differenceText: _formatHorizonDifference(
                  simulatedYearsRemaining -
                      officialYearsRemaining,
                ),
                differenceType: _differenceType(
                  officialYearsRemaining.toDouble() -
                      simulatedYearsRemaining.toDouble(),
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _ComparisonCard(
                icon: Icons.trending_up_rounded,
                title: 'Património projetado',
                officialValue: _formatCurrency(
                  officialProjectedPortfolio,
                ),
                simulatedValue: _formatCurrency(
                  simulatedProjectedPortfolio,
                ),
                differenceText:
                    _formatPortfolioDifference(
                  difference:
                      viewModel.portfolioDifference,
                  percentage:
                      viewModel.portfolioDifferencePercent,
                ),
                differenceType: _differenceType(
                  viewModel.portfolioDifference,
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingLg,
              ),
              _BloomInsightCard(
                insight: viewModel.bloomInsight,
                freedomYearsGained:
                    viewModel.freedomYearsGained,
                portfolioDifference:
                    viewModel.portfolioDifference,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatCurrency(double value) {
    return '${value.toStringAsFixed(0)} €';
  }

  static String _formatCurrencyDifference(
    double value, {
    String suffix = '',
  }) {
    if (value == 0) {
      return 'Sem diferença';
    }

    final String sign = value > 0 ? '+' : '-';

    return '$sign${value.abs().toStringAsFixed(0)} €$suffix';
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
      return '+$years $unit de liberdade financeira';
    }

    return '-$years $unit de liberdade financeira';
  }

  static String _formatHorizonDifference(
    int difference,
  ) {
    if (difference == 0) {
      return 'Mesmo horizonte';
    }

    final int years = difference.abs();
    final String unit = years == 1 ? 'ano' : 'anos';

    if (difference < 0) {
      return '$years $unit mais cedo';
    }

    return '$years $unit mais tarde';
  }

  static String _formatPortfolioDifference({
    required double difference,
    required double percentage,
  }) {
    if (difference == 0) {
      return 'Sem diferença';
    }

    final String sign = difference > 0 ? '+' : '-';

    return '$sign${difference.abs().toStringAsFixed(0)} € '
        '(${percentage >= 0 ? '+' : '-'}'
        '${percentage.abs().toStringAsFixed(1)}%)';
  }

  static _DifferenceType _differenceType(
    double difference,
  ) {
    if (difference > 0) {
      return _DifferenceType.positive;
    }

    if (difference < 0) {
      return _DifferenceType.negative;
    }

    return _DifferenceType.neutral;
  }
}

enum _DifferenceType {
  positive,
  negative,
  neutral,
}

class _ScenarioLabels extends StatelessWidget {
  const _ScenarioLabels();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ScenarioLabel(
            icon: Icons.home_outlined,
            label: 'Plano Oficial',
            highlighted: false,
          ),
        ),
        SizedBox(
          width: DesignTokens.spacingSm,
        ),
        Expanded(
          child: _ScenarioLabel(
            icon: Icons.science_outlined,
            label: 'Cenário Simulado',
            highlighted: true,
          ),
        ),
      ],
    );
  }
}

class _ScenarioLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlighted;

  const _ScenarioLabel({
    required this.icon,
    required this.label,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: highlighted
            ? DesignTokens.primaryLight
            : DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
        border: Border.all(
          color: highlighted
              ? DesignTokens.primary.withValues(
                  alpha: 0.22,
                )
              : DesignTokens.borderSoft,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 22,
            color: highlighted
                ? DesignTokens.primary
                : DesignTokens.textSecondary,
          ),
          const SizedBox(
            height: DesignTokens.spacingXs,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color: highlighted
                  ? DesignTokens.primary
                  : DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String officialValue;
  final String simulatedValue;
  final String differenceText;
  final _DifferenceType differenceType;

  const _ComparisonCard({
    required this.icon,
    required this.title,
    required this.officialValue,
    required this.simulatedValue,
    required this.differenceText,
    required this.differenceType,
  });

  @override
  Widget build(BuildContext context) {
    final Color differenceColor;

    switch (differenceType) {
      case _DifferenceType.positive:
        differenceColor = DesignTokens.primary;
      case _DifferenceType.negative:
        differenceColor = DesignTokens.textSecondary;
      case _DifferenceType.neutral:
        differenceColor = DesignTokens.textSecondary;
    }

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
                child: Icon(
                  icon,
                  size: 24,
                  color: DesignTokens.primary,
                ),
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: DesignTokens.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ComparisonValue(
                  label: 'Plano Oficial',
                  value: officialValue,
                  highlighted: false,
                ),
              ),
              Container(
                width: 1,
                height: 52,
                margin: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingMd,
                ),
                color: DesignTokens.borderSoft,
              ),
              Expanded(
                child: _ComparisonValue(
                  label: 'Simulado',
                  value: simulatedValue,
                  highlighted: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingSm,
            ),
            decoration: BoxDecoration(
              color: differenceColor.withValues(
                alpha: 0.08,
              ),
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Text(
              differenceText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w700,
                color: differenceColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonValue extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;

  const _ComparisonValue({
    required this.label,
    required this.value,
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
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
          style: TextStyle(
            fontSize: 20,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: highlighted
                ? DesignTokens.primary
                : DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _DecisionCostCard extends StatelessWidget {
  final double monthlyDifference;
  final double dailyDifference;
  final double yearlyDifference;

  const _DecisionCostCard({
    required this.monthlyDifference,
    required this.dailyDifference,
    required this.yearlyDifference,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDifference = monthlyDifference != 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.primaryLight,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.primary.withValues(
            alpha: 0.20,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.calendar_view_day_outlined,
                size: 22,
                color: DesignTokens.primary,
              ),
              SizedBox(
                width: DesignTokens.spacingSm,
              ),
              Text(
                'Escala da decisão',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          if (!hasDifference)
            const Text(
              'O investimento mensal é igual nos dois planos.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: DesignTokens.textSecondary,
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: _DecisionMetric(
                    label: 'Por dia',
                    value:
                        '${dailyDifference >= 0 ? '+' : '-'}'
                        '${dailyDifference.abs().toStringAsFixed(2)} €',
                  ),
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                Expanded(
                  child: _DecisionMetric(
                    label: 'Por mês',
                    value:
                        '${monthlyDifference >= 0 ? '+' : '-'}'
                        '${monthlyDifference.abs().toStringAsFixed(0)} €',
                  ),
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                Expanded(
                  child: _DecisionMetric(
                    label: 'Por ano',
                    value:
                        '${yearlyDifference >= 0 ? '+' : '-'}'
                        '${yearlyDifference.abs().toStringAsFixed(0)} €',
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _DecisionMetric extends StatelessWidget {
  final String label;
  final String value;

  const _DecisionMetric({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingXs,
        vertical: DesignTokens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
      ),
      child: Column(
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
            style: const TextStyle(
              fontSize: 15,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BloomInsightCard extends StatelessWidget {
  final String insight;
  final int freedomYearsGained;
  final double portfolioDifference;

  const _BloomInsightCard({
    required this.insight,
    required this.freedomYearsGained,
    required this.portfolioDifference,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.primaryLight,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.primary.withValues(
            alpha: 0.20,
          ),
        ),
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
                child: const Icon(
                  Icons.auto_awesome_outlined,
                  size: 24,
                  color: DesignTokens.primary,
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
                    const Text(
                      'Bloom Insight',
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: DesignTokens.spacingSm,
                    ),
                    Text(
                      insight,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (freedomYearsGained != 0 ||
              portfolioDifference != 0) ...[
            const SizedBox(
              height: DesignTokens.spacingLg,
            ),
            Row(
              children: [
                if (freedomYearsGained != 0)
                  Expanded(
                    child: _InsightMetric(
                      icon: Icons.access_time_rounded,
                      value:
                          '${freedomYearsGained > 0 ? '+' : '-'}'
                          '${freedomYearsGained.abs()}',
                      label: freedomYearsGained.abs() == 1
                          ? 'ano de liberdade'
                          : 'anos de liberdade',
                    ),
                  ),
                if (freedomYearsGained != 0 &&
                    portfolioDifference != 0)
                  const SizedBox(
                    width: DesignTokens.spacingSm,
                  ),
                if (portfolioDifference != 0)
                  Expanded(
                    child: _InsightMetric(
                      icon: Icons.trending_up_rounded,
                      value:
                          '${portfolioDifference > 0 ? '+' : '-'}'
                          '${portfolioDifference.abs().toStringAsFixed(0)} €',
                      label: 'património projetado',
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _InsightMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InsightMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        DesignTokens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 21,
            color: DesignTokens.primary,
          ),
          const SizedBox(
            height: DesignTokens.spacingXs,
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.primary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingXxs,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _BloomHeader extends StatelessWidget {
  const _BloomHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.eco_outlined,
          size: 30,
          color: DesignTokens.primary,
        ),
        SizedBox(
          width: DesignTokens.spacingSm,
        ),
        Text(
          'Bloom',
          style: TextStyle(
            fontSize: 24,
            height: 1,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}