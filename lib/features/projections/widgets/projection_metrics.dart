import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class ProjectionMetrics extends StatelessWidget {
  final int yearsRemaining;
  final int targetYear;

  const ProjectionMetrics({
    super.key,
    required this.yearsRemaining,
    required this.targetYear,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useVerticalLayout =
            constraints.maxWidth < 340;

        final Widget horizonCard = ProjectionMetricCard(
          icon: Icons.calendar_today_outlined,
          label: 'Horizonte',
          value: '$yearsRemaining anos',
        );

        final Widget targetYearCard = ProjectionMetricCard(
          icon: Icons.flag_outlined,
          label: 'Ano objetivo',
          value: '$targetYear',
        );

        if (useVerticalLayout) {
          return Column(
            children: [
              horizonCard,
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              targetYearCard,
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: horizonCard,
            ),
            const SizedBox(
              width: DesignTokens.spacingMd,
            ),
            Expanded(
              child: targetYearCard,
            ),
          ],
        );
      },
    );
  }
}

class ProjectionMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProjectionMetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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