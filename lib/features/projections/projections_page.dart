import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../core/formatters/financial_formatter.dart';
import '../../models/user_profile.dart';
import '../dashboard/dashboard_view_model.dart';

class ProjectionsPage extends StatelessWidget {
  final UserProfile profile;

  const ProjectionsPage({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel =
        DashboardViewModel.fromProfile(profile);

    final double fireNumber =
        viewModel.fireNumber.toDouble();

    final double projectedPortfolio =
        viewModel.projectedPortfolio.toDouble();

    final double progress = viewModel.progress
        .toDouble()
        .clamp(0.0, 1.0)
        .toDouble();

    final double portfolioDifference =
        projectedPortfolio - fireNumber;

    final double absoluteDifference =
        portfolioDifference.abs();

    final double remainingPortfolio = math.max(
      fireNumber - projectedPortfolio,
      0.0,
    );

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
                'Projeções',
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
                'Acompanha a evolução prevista do teu património.',
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
              _ProjectionSummaryCard(
                projectedPortfolio: projectedPortfolio,
                fireNumber: fireNumber,
                progress: progress,
                onTrack: viewModel.onTrack,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              Row(
                children: [
                  Expanded(
                    child: _ProjectionMetricCard(
                      icon: Icons.calendar_today_outlined,
                      label: 'Horizonte',
                      value:
                          '${viewModel.yearsRemaining} anos',
                    ),
                  ),
                  const SizedBox(
                    width: DesignTokens.spacingMd,
                  ),
                  Expanded(
                    child: _ProjectionMetricCard(
                      icon: Icons.flag_outlined,
                      label: 'Ano objetivo',
                      value: '${viewModel.targetYear}',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _DifferenceCard(
                onTrack: viewModel.onTrack,
                difference: absoluteDifference,
                remainingPortfolio: remainingPortfolio,
                targetAge: viewModel.targetAge,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _MilestoneCard(
                targetAge: viewModel.targetAge,
                targetYear: viewModel.targetYear,
                projectedPortfolio: projectedPortfolio,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectionSummaryCard extends StatelessWidget {
  final double projectedPortfolio;
  final double fireNumber;
  final double progress;
  final bool onTrack;

  const _ProjectionSummaryCard({
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                        color:
                            DesignTokens.textSecondary,
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
              Container(
                width:
                    DesignTokens.iconContainerMedium,
                height:
                    DesignTokens.iconContainerMedium,
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
            children: [
              Text(
                FinancialFormatter.percentage(
                  progress,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.primary,
                ),
              ),
              const Spacer(),
              Text(
                'Objetivo: ${FinancialFormatter.compactCurrency(fireNumber)}',
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  color: DesignTokens.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          Container(
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

class _ProjectionMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ProjectionMetricCard({
    required this.icon,
    required this.label,
    required this.value,
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
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: DesignTokens.primaryLight,
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Icon(
              icon,
              size: 22,
              color: DesignTokens.primary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingXxs,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifferenceCard extends StatelessWidget {
  final bool onTrack;
  final double difference;
  final double remainingPortfolio;
  final int targetAge;

  const _DifferenceCard({
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
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:
                DesignTokens.iconContainerMedium,
            height:
                DesignTokens.iconContainerMedium,
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

class _MilestoneCard extends StatelessWidget {
  final int targetAge;
  final int targetYear;
  final double projectedPortfolio;

  const _MilestoneCard({
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
                  'Em $targetYear, aos $targetAge anos, o património projetado é de '
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