import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/user_profile.dart';
import '../../shared/widgets/bloom_card.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/progress_card.dart';

class DashboardPage extends StatelessWidget {
  final UserProfile profile;

  const DashboardPage({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final currentAge = profile.age ?? 0;

    final targetFinancialIndependenceAge =
        profile.targetFinancialIndependenceAge ?? currentAge;

    final yearsRemaining =
        targetFinancialIndependenceAge - currentAge;

    final targetYear = currentYear + yearsRemaining;
    final monthlyInvestment = profile.monthlyInvestment ?? 0;

    final progress = yearsRemaining > 0
        ? (1 - (yearsRemaining / 40)).clamp(0.10, 1.0)
        : 1.0;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.eco_outlined,
                    size: 30,
                    color: AppTheme.primary,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Bloom',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              PageHeader(
                subtitle: 'Olá, ${profile.name} 👋',
                title: 'O Meu Plano',
              ),
              const SizedBox(height: 24),
              ProgressCard(
                progress: progress,
                title: 'Progresso do plano',
                message: yearsRemaining > 0
                    ? 'Tens cerca de $yearsRemaining anos para construir o teu objetivo.'
                    : 'O teu objetivo precisa de ser revisto.',
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: BloomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.flag_outlined,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Objetivo',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$targetFinancialIndependenceAge anos',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: BloomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Ano objetivo',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$targetYear',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              BloomCard(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.savings_outlined,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Investimento mensal',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${monthlyInvestment.toStringAsFixed(0)} € / mês',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              BloomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.auto_awesome_outlined,
                          color: AppTheme.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Insight Bloom',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      monthlyInvestment > 0
                          ? 'Se aumentares o investimento mensal em 10%, poderás aproximar-te mais depressa do teu objetivo.'
                          : 'Adiciona um valor mensal para começares a construir o teu plano.',
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.45,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Simular cenários',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'O simulador será o próximo passo da Bloom.',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}