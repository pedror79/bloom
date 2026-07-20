import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../models/simulation_scenario.dart';
import '../../models/user_profile.dart';
import 'comparison_chart.dart';
import 'comparison_summary_card.dart';
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
              ComparisonChart(
                points: viewModel.chartPoints,
              ),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              ComparisonSummaryCard(
                officialProjectedPortfolio:
                    officialProjectedPortfolio,
                simulatedProjectedPortfolio:
                    simulatedProjectedPortfolio,
                officialTargetAge:
                    viewModel.official.targetAge,
                simulatedTargetAge:
                    viewModel.simulated.targetAge,
                officialMonthlyInvestment:
                    officialMonthlyInvestment,
                simulatedMonthlyInvestment:
                    simulatedMonthlyInvestment,
                portfolioDifference:
                    viewModel.portfolioDifference,
                monthlyInvestmentDifference:
                    viewModel.monthlyInvestmentDifference,
                dailyInvestmentDifference:
                    viewModel.dailyInvestmentDifference,
                freedomYearsGained:
                    viewModel.freedomYearsGained,
              ),
              const SizedBox(
                height: DesignTokens.spacingLg,
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
              Expanded(
                child: Text(
                  'Escala da decisão',
                  style: TextStyle(
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
            height: DesignTokens.spacingXs,
          ),
          const Text(
            'Traduz a diferença de investimento numa escala mais simples.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
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
                    value: _formatSignedCurrency(
                      dailyDifference,
                      decimals: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                Expanded(
                  child: _DecisionMetric(
                    label: 'Por mês',
                    value: _formatSignedCurrency(
                      monthlyDifference,
                      decimals: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                Expanded(
                  child: _DecisionMetric(
                    label: 'Por ano',
                    value: _formatSignedCurrency(
                      yearlyDifference,
                      decimals: 0,
                    ),
                  ),
                ),
              ],
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
    final bool hasFreedomDifference =
        freedomYearsGained != 0;

    final bool hasPortfolioDifference =
        portfolioDifference != 0;

    final bool hasMetrics =
        hasFreedomDifference || hasPortfolioDifference;

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
          if (hasMetrics) ...[
            const SizedBox(
              height: DesignTokens.spacingLg,
            ),
            Row(
              children: [
                if (hasFreedomDifference)
                  Expanded(
                    child: _InsightMetric(
                      icon: Icons.access_time_rounded,
                      value:
                          '${freedomYearsGained > 0 ? '+' : '-'}'
                          '${freedomYearsGained.abs()}',
                      label:
                          freedomYearsGained.abs() == 1
                              ? 'ano de liberdade'
                              : 'anos de liberdade',
                    ),
                  ),
                if (hasFreedomDifference &&
                    hasPortfolioDifference)
                  const SizedBox(
                    width: DesignTokens.spacingSm,
                  ),
                if (hasPortfolioDifference)
                  Expanded(
                    child: _InsightMetric(
                      icon: Icons.trending_up_rounded,
                      value: _formatSignedCurrency(
                        portfolioDifference,
                      ),
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

  static String _formatSignedCurrency(double value) {
    final String sign = value > 0 ? '+' : '-';

    final String digits =
        value.abs().toStringAsFixed(0);

    final String formattedDigits =
        digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => '.',
    );

    return '$sign$formattedDigits €';
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