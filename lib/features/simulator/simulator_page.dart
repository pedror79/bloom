import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../models/user_profile.dart';

class SimulatorPage extends StatefulWidget {
  final UserProfile profile;

  const SimulatorPage({
    super.key,
    required this.profile,
  });

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  late double _monthlyInvestment;
  late int _targetAge;

  @override
  void initState() {
    super.initState();

    _monthlyInvestment =
        (widget.profile.monthlyInvestment ?? 0).toDouble();

    final int currentAge = widget.profile.age ?? 18;

    _targetAge =
        widget.profile.targetFinancialIndependenceAge ??
            currentAge + 20;
  }

  @override
  Widget build(BuildContext context) {
    final int currentAge = widget.profile.age ?? 18;

    final int minimumTargetAge = currentAge + 1;

    final int maximumTargetAge =
        minimumTargetAge > 80 ? minimumTargetAge : 80;

    final int safeTargetAge = _targetAge.clamp(
      minimumTargetAge,
      maximumTargetAge,
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
                'Simulador',
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
                'Experimenta diferentes cenários para o teu plano.',
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
              _SimulatorControlCard(
                icon: Icons.savings_outlined,
                title: 'Investimento mensal',
                value:
                    '${_monthlyInvestment.toStringAsFixed(0)} € / mês',
                child: Slider(
                  value: _monthlyInvestment.clamp(
                    0,
                    5000,
                  ),
                  min: 0,
                  max: 5000,
                  divisions: 100,
                  label:
                      '${_monthlyInvestment.toStringAsFixed(0)} €',
                  onChanged: (value) {
                    setState(() {
                      _monthlyInvestment = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _SimulatorControlCard(
                icon: Icons.flag_outlined,
                title: 'Idade objetivo',
                value: '$safeTargetAge anos',
                child: Slider(
                  value: safeTargetAge.toDouble(),
                  min: minimumTargetAge.toDouble(),
                  max: maximumTargetAge.toDouble(),
                  divisions:
                      maximumTargetAge - minimumTargetAge,
                  label: '$safeTargetAge anos',
                  onChanged: (value) {
                    setState(() {
                      _targetAge = value.round();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              _ScenarioSummaryCard(
                monthlyInvestment: _monthlyInvestment,
                targetAge: safeTargetAge,
                yearsRemaining: safeTargetAge - currentAge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimulatorControlCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Widget child;

  const _SimulatorControlCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.child,
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
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
                        fontSize: 22,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          child,
        ],
      ),
    );
  }
}

class _ScenarioSummaryCard extends StatelessWidget {
  final double monthlyInvestment;
  final int targetAge;
  final int yearsRemaining;

  const _ScenarioSummaryCard({
    required this.monthlyInvestment,
    required this.targetAge,
    required this.yearsRemaining,
  });

  @override
  Widget build(BuildContext context) {
    final double totalContributions =
        monthlyInvestment * yearsRemaining * 12;

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
          const Text(
            'Resumo do cenário',
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
          _ScenarioRow(
            label: 'Horizonte',
            value: '$yearsRemaining anos',
          ),
          const SizedBox(
            height: DesignTokens.spacingSm,
          ),
          _ScenarioRow(
            label: 'Idade objetivo',
            value: '$targetAge anos',
          ),
          const SizedBox(
            height: DesignTokens.spacingSm,
          ),
          _ScenarioRow(
            label: 'Total investido',
            value:
                '${totalContributions.toStringAsFixed(0)} €',
          ),
        ],
      ),
    );
  }
}

class _ScenarioRow extends StatelessWidget {
  final String label;
  final String value;

  const _ScenarioRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              height: 1.3,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
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