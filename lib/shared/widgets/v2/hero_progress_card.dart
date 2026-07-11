import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';
import 'circular_progress_ring.dart';
import 'status_badge.dart';

class HeroProgressCard extends StatelessWidget {
  final double progress;
  final String progressLabel;
  final int yearsRemaining;
  final int targetAge;
  final int targetYear;
  final BloomStatus status;
  final String statusLabel;

  const HeroProgressCard({
    super.key,
    required this.progress,
    required this.progressLabel,
    required this.yearsRemaining,
    required this.targetAge,
    required this.targetYear,
    required this.status,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusXl,
        ),
        border: Border.all(
          color: DesignTokens.borderSoft,
        ),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              DesignTokens.spacingXl,
              DesignTokens.spacingXl,
              DesignTokens.spacingXl,
              DesignTokens.spacingLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progresso do plano',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingLg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressRing(
                      progress: progress,
                      value: progressLabel,
                      label: 'do objetivo',
                      size: 152,
                      strokeWidth: 13,
                    ),
                    const SizedBox(
                      width: DesignTokens.spacingXl,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Faltam',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              color: DesignTokens.textSecondary,
                            ),
                          ),
                          const SizedBox(
                            height: DesignTokens.spacingXxs,
                          ),
                          Text(
                            '$yearsRemaining anos',
                            style: const TextStyle(
                              fontSize: 30,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.8,
                              color: DesignTokens.textPrimary,
                            ),
                          ),
                          const SizedBox(
                            height: DesignTokens.spacingSm,
                          ),
                          const Text(
                            'até à tua independência financeira.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: DesignTokens.textSecondary,
                            ),
                          ),
                          const SizedBox(
                            height: DesignTokens.spacingMd,
                          ),
                          StatusBadge(
                            status: status,
                            label: statusLabel,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: DesignTokens.borderSoft,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingXl,
              vertical: DesignTokens.spacingMd,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HeroMetric(
                    icon: Icons.calendar_month_outlined,
                    label: 'Idade prevista',
                    value: '$targetAge anos',
                  ),
                ),
                Container(
                  width: 1,
                  height: 48,
                  margin: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacingMd,
                  ),
                  color: DesignTokens.borderSoft,
                ),
                Expanded(
                  child: _HeroMetric(
                    icon: Icons.flag_outlined,
                    label: 'Ano objetivo',
                    value: '$targetYear',
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

class _HeroMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HeroMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: DesignTokens.primaryLight,
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusSm,
            ),
          ),
          child: Icon(
            icon,
            size: 22,
            color: DesignTokens.primary,
          ),
        ),
        const SizedBox(width: DesignTokens.spacingSm),
        Expanded(
          child: Column(
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
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                  color: DesignTokens.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}