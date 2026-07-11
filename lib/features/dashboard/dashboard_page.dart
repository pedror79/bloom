import 'package:flutter/material.dart';

import '../../core/formatters/financial_formatter.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_profile.dart';
import '../../shared/widgets/bloom_card.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/progress_card.dart';
import 'dashboard_view_model.dart';

class DashboardPage extends StatelessWidget {
  final UserProfile profile;

  const DashboardPage({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = DashboardViewModel.fromProfile(profile);

    final currentMonthlyInvestment =
        profile.monthlyInvestment ?? 0;

    final monthlyInvestmentDifference =
        viewModel.requiredMonthlyInvestment -
        currentMonthlyInvestment;

    final insightMessage = _buildInsightMessage(
      viewModel: viewModel,
      currentMonthlyInvestment: currentMonthlyInvestment,
      monthlyInvestmentDifference: monthlyInvestmentDifference,
    );

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
                progress: viewModel.progress,
                title: 'Progresso do plano',
                message: viewModel.onTrack
                    ? 'Estás no bom caminho para atingir a tua independência financeira.'
                    : 'Tens cerca de ${viewModel.yearsRemaining} anos para construir o teu objetivo.',
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: BloomCard(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            '${viewModel.targetAge} anos',
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            '${viewModel.targetYear}',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.account_balance_outlined,
                          color: AppTheme.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Objetivo financeiro',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Número FIRE',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      FinancialFormatter.currency(
                        viewModel.fireNumber,
                      ),
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Património necessário na idade objetivo',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: AppTheme.textSecondary,
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
                          Icons.trending_up_rounded,
                          color: AppTheme.primary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Projeção do património',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      FinancialFormatter.currency(
                        viewModel.projectedPortfolio,
                      ),
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      viewModel.onTrack
                          ? 'A projeção está acima do teu objetivo FIRE.'
                          : 'A projeção está abaixo do teu objetivo FIRE.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: viewModel.onTrack
                            ? AppTheme.primary
                            : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              BloomCard(
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(
                          alpha: 0.10,
                        ),
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Investimento mensal atual',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            FinancialFormatter.monthlyCurrency(
                              currentMonthlyInvestment,
                            ),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Necessário: '
                            '${FinancialFormatter.monthlyCurrency(viewModel.requiredMonthlyInvestment)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
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
                      insightMessage,
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

  String _buildInsightMessage({
    required DashboardViewModel viewModel,
    required double currentMonthlyInvestment,
    required double monthlyInvestmentDifference,
  }) {
    if (viewModel.onTrack) {
      if (viewModel.requiredMonthlyInvestment == 0) {
        return 'O teu património atual poderá ser suficiente para atingir '
            'o objetivo, mesmo sem novos investimentos mensais.';
      }

      final monthlySurplus =
          currentMonthlyInvestment -
          viewModel.requiredMonthlyInvestment;

      if (monthlySurplus > 0) {
        return 'Estás a investir cerca de '
            '${FinancialFormatter.monthlyCurrency(monthlySurplus)} '
            'acima do valor necessário para o teu objetivo.';
      }

      return 'Mantendo o teu ritmo atual, a projeção indica que '
          'poderás atingir o objetivo aos ${viewModel.targetAge} anos.';
    }

    if (monthlyInvestmentDifference > 0) {
      return 'Para atingires o objetivo aos ${viewModel.targetAge} anos, '
          'precisas de aumentar o investimento mensal em cerca de '
          '${FinancialFormatter.monthlyCurrency(monthlyInvestmentDifference)}.';
    }

    return 'Revê os dados do teu plano para encontrares uma estratégia '
        'mais adequada ao teu objetivo financeiro.';
  }
}