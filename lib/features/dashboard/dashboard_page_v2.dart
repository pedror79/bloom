import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../core/formatters/financial_formatter.dart';
import '../../models/user_profile.dart';
import '../../shared/widgets/v2/hero_progress_card.dart';
import '../../shared/widgets/v2/insight_card.dart';
import '../../shared/widgets/v2/metric_card.dart';
import '../../shared/widgets/v2/primary_cta_button.dart';
import '../../shared/widgets/v2/status_badge.dart';
import 'dashboard_view_model.dart';

class DashboardPageV2 extends StatelessWidget {
  final UserProfile profile;

  const DashboardPageV2({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel =
        DashboardViewModel.fromProfile(profile);

    final double currentMonthlyInvestment =
        (profile.monthlyInvestment ?? 0).toDouble();

    final double fireNumber = viewModel.fireNumber.toDouble();

    final double projectedPortfolio =
        viewModel.projectedPortfolio.toDouble();

    final double requiredMonthlyInvestment =
        viewModel.requiredMonthlyInvestment.toDouble();

    final double progress = viewModel.progress
        .toDouble()
        .clamp(0.0, 1.0)
        .toDouble();

    final double missingPortfolio = math.max(
      fireNumber - projectedPortfolio,
      0.0,
    );

    final double monthlyDifference = math.max(
      requiredMonthlyInvestment - currentMonthlyInvestment,
      0.0,
    );

    final String progressLabel =
        FinancialFormatter.percentage(progress);

    final String displayName = profile.name.trim().isEmpty
        ? 'Investidor'
        : profile.name.trim();

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
              _DashboardIntroduction(
                displayName: displayName,
              ),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              HeroProgressCard(
                progress: progress,
                progressLabel: progressLabel,
                yearsRemaining: viewModel.yearsRemaining,
                targetAge: viewModel.targetAge,
                targetYear: viewModel.targetYear,
                status: viewModel.onTrack
                    ? BloomStatus.success
                    : BloomStatus.danger,
                statusLabel: viewModel.onTrack
                    ? 'No bom caminho'
                    : 'Rever plano',
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _DashboardMetrics(
                fireNumber: fireNumber,
                projectedPortfolio: projectedPortfolio,
                progress: progress,
                missingPortfolio: missingPortfolio,
                onTrack: viewModel.onTrack,
                onFireNumberTap: () {
                  _showComingSoon(context);
                },
                onProjectionTap: () {
                  _showComingSoon(context);
                },
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _InvestmentCard(
                currentInvestment: currentMonthlyInvestment,
                requiredInvestment: requiredMonthlyInvestment,
                onTap: () {
                  _showComingSoon(context);
                },
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              InsightCard(
                title: 'Insight Bloom',
                message: _buildInsightMessage(
                  viewModel: viewModel,
                  monthlyDifference: monthlyDifference,
                ),
                onTap: () {
                  _showComingSoon(context);
                },
              ),
              const SizedBox(
                height: DesignTokens.spacingLg,
              ),
              PrimaryCTAButton(
                text: 'Simular cenários',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  _showComingSoon(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildInsightMessage({
    required DashboardViewModel viewModel,
    required double monthlyDifference,
  }) {
    if (viewModel.onTrack) {
      return 'Mantendo o ritmo atual, estás alinhado para atingir '
          'a independência financeira aos '
          '${viewModel.targetAge} anos.';
    }

    if (monthlyDifference > 0) {
      return 'Para atingires o objetivo aos '
          '${viewModel.targetAge} anos, aumenta o investimento '
          'mensal em cerca de '
          '${FinancialFormatter.monthlyCurrency(monthlyDifference)}.';
    }

    return 'O teu plano precisa de alguns ajustes. Simula diferentes '
        'cenários para encontrares uma estratégia mais confortável.';
  }

  void _showComingSoon(BuildContext context) {
    final ScaffoldMessengerState messenger =
        ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'Esta funcionalidade será adicionada numa próxima sprint.',
          ),
        ),
      );
  }
}

class _DashboardIntroduction extends StatelessWidget {
  final String displayName;

  const _DashboardIntroduction({
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, $displayName 👋',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            height: 1.3,
            fontWeight: FontWeight.w500,
            color: DesignTokens.textSecondary,
          ),
        ),
        const SizedBox(
          height: DesignTokens.spacingXs,
        ),
        const Text(
          'O Meu Plano',
          style: TextStyle(
            fontSize: 34,
            height: 1.08,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.9,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _DashboardMetrics extends StatelessWidget {
  final double fireNumber;
  final double projectedPortfolio;
  final double progress;
  final double missingPortfolio;
  final bool onTrack;
  final VoidCallback onFireNumberTap;
  final VoidCallback onProjectionTap;

  const _DashboardMetrics({
    required this.fireNumber,
    required this.projectedPortfolio,
    required this.progress,
    required this.missingPortfolio,
    required this.onTrack,
    required this.onFireNumberTap,
    required this.onProjectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final Widget objectiveCard = MetricCard(
      title: 'Objetivo',
      subtitle: 'Independência financeira',
      value: FinancialFormatter.compactCurrency(
        fireNumber,
      ),
      icon: Icons.flag_outlined,
      actionLabel: 'Ver detalhes',
      supportingContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusPill,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: DesignTokens.progressTrack,
              valueColor: const AlwaysStoppedAnimation<Color>(
                DesignTokens.primary,
              ),
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingSm,
          ),
          Text(
            onTrack
                ? 'Objetivo alcançável'
                : 'Faltam '
                    '${FinancialFormatter.compactCurrency(missingPortfolio)}',
            style: const TextStyle(
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w600,
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
      onTap: onFireNumberTap,
    );

    final Widget projectedPortfolioCard = MetricCard(
      title: 'Património projetado',
      subtitle: 'À idade de independência',
      value: FinancialFormatter.compactCurrency(
        projectedPortfolio,
      ),
      icon: Icons.trending_up_rounded,
      actionLabel: 'Ver projeção',
      supportingContent: Text(
        onTrack
            ? 'Acima do objetivo'
            : 'Abaixo do objetivo',
        style: TextStyle(
          fontSize: 13,
          height: 1.3,
          fontWeight: FontWeight.w700,
          color: onTrack
              ? DesignTokens.success
              : DesignTokens.danger,
        ),
      ),
      onTap: onProjectionTap,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useVerticalLayout =
            constraints.maxWidth < 360;

        if (useVerticalLayout) {
          return Column(
            children: [
              SizedBox(
                height: 290,
                child: objectiveCard,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              SizedBox(
                height: 290,
                child: projectedPortfolioCard,
              ),
            ],
          );
        }

        return SizedBox(
          height: 290,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: objectiveCard,
              ),
              const SizedBox(
                width: DesignTokens.spacingMd,
              ),
              Expanded(
                child: projectedPortfolioCard,
              ),
            ],
          ),
        );
      },
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
        Spacer(),
        CircleAvatar(
          radius: 19,
          backgroundColor: DesignTokens.primaryLight,
          child: Icon(
            Icons.person_outline_rounded,
            size: 21,
            color: DesignTokens.primary,
          ),
        ),
      ],
    );
  }
}

class _InvestmentCard extends StatelessWidget {
  final double currentInvestment;
  final double requiredInvestment;
  final VoidCallback onTap;

  const _InvestmentCard({
    required this.currentInvestment,
    required this.requiredInvestment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        child: Ink(
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
          child: Padding(
            padding: const EdgeInsets.all(
              DesignTokens.spacingLg,
            ),
            child: Row(
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
                    Icons.savings_outlined,
                    size: 25,
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
                        'Investimento mensal',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.2,
                          fontWeight: FontWeight.w700,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: DesignTokens.spacingSm,
                      ),
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _InvestmentMetric(
                              label: 'Atual',
                              value: FinancialFormatter
                                  .monthlyCurrency(
                                currentInvestment,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 42,
                            margin: const EdgeInsets.symmetric(
                              horizontal:
                                  DesignTokens.spacingMd,
                            ),
                            color: DesignTokens.borderSoft,
                          ),
                          Expanded(
                            child: _InvestmentMetric(
                              label: 'Necessário',
                              value: FinancialFormatter
                                  .monthlyCurrency(
                                requiredInvestment,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: DesignTokens.spacingSm,
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: DesignTokens.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InvestmentMetric extends StatelessWidget {
  final String label;
  final String value;

  const _InvestmentMetric({
    required this.label,
    required this.value,
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
          height: DesignTokens.spacingXxs,
        ),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}