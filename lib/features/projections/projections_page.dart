import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../models/user_profile.dart';
import '../dashboard/dashboard_view_model.dart';
import 'widgets/bloom_header.dart';
import 'widgets/difference_card.dart';
import 'widgets/milestone_card.dart';
import 'widgets/page_introduction.dart';
import 'widgets/projection_metrics.dart';
import 'widgets/projection_summary_card.dart';
import 'widgets/required_investment_card.dart';
import 'widgets/simulation_controls_card.dart';

class ProjectionsPage extends StatefulWidget {
  final UserProfile profile;
  final ValueChanged<UserProfile>? onProfileChanged;

  const ProjectionsPage({
    super.key,
    required this.profile,
    this.onProfileChanged,
  });

  @override
  State<ProjectionsPage> createState() =>
      _ProjectionsPageState();
}

class _ProjectionsPageState extends State<ProjectionsPage> {
  late UserProfile _simulationProfile;

  @override
  void initState() {
    super.initState();

    _simulationProfile = widget.profile.copyWith();
  }

  @override
  void didUpdateWidget(
    covariant ProjectionsPage oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.profile != widget.profile) {
      _simulationProfile = widget.profile.copyWith();
    }
  }

  void _applyProfileUpdate(UserProfile updatedProfile) {
    setState(() {
      _simulationProfile = updatedProfile;
    });

    widget.onProfileChanged?.call(updatedProfile);
  }

  void _updateCurrentPortfolio(double value) {
    _applyProfileUpdate(
      _simulationProfile.copyWith(
        currentPortfolio: value,
      ),
    );
  }

  void _updateMonthlyInvestment(double value) {
    _applyProfileUpdate(
      _simulationProfile.copyWith(
        monthlyInvestment: value,
      ),
    );
  }

  void _updateDesiredMonthlyIncome(double value) {
    _applyProfileUpdate(
      _simulationProfile.copyWith(
        desiredMonthlyIncomeToday: value,
      ),
    );
  }

  void _updateTargetAge(double value) {
    _applyProfileUpdate(
      _simulationProfile.copyWith(
        targetFinancialIndependenceAge: value.round(),
      ),
    );
  }

  void _resetSimulation() {
    _applyProfileUpdate(
      widget.profile.copyWith(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DashboardViewModel viewModel =
        DashboardViewModel.fromProfile(
      _simulationProfile,
    );

    final double fireNumber =
        viewModel.fireNumber.toDouble();

    final double projectedPortfolio =
        viewModel.projectedPortfolio.toDouble();

    final double requiredMonthlyInvestment =
        viewModel.requiredMonthlyInvestment.toDouble();

    final double currentMonthlyInvestment =
        (_simulationProfile.monthlyInvestment ?? 0.0)
            .toDouble();

    final double progress = viewModel.progress
        .toDouble()
        .clamp(0.0, 1.0)
        .toDouble();

    final double portfolioDifference =
        projectedPortfolio - fireNumber;

    final double displayedDifference =
        portfolioDifference.abs();

    final double remainingPortfolio = math.max(
      fireNumber - projectedPortfolio,
      0.0,
    );

    final int minimumTargetAge = math.max(
      (_simulationProfile.age ?? 30) + 1,
      31,
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
              const BloomHeader(),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              const PageIntroduction(),
              const SizedBox(
                height: DesignTokens.spacingXl,
              ),
              SimulationControlsCard(
                profile: _simulationProfile,
                minimumTargetAge: minimumTargetAge,
                onCurrentPortfolioChanged:
                    _updateCurrentPortfolio,
                onMonthlyInvestmentChanged:
                    _updateMonthlyInvestment,
                onDesiredMonthlyIncomeChanged:
                    _updateDesiredMonthlyIncome,
                onTargetAgeChanged: _updateTargetAge,
                onReset: _resetSimulation,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              ProjectionSummaryCard(
                projectedPortfolio: projectedPortfolio,
                fireNumber: fireNumber,
                progress: progress,
                onTrack: viewModel.onTrack,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              ProjectionMetrics(
                yearsRemaining: viewModel.yearsRemaining,
                targetYear: viewModel.targetYear,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              RequiredInvestmentCard(
                currentMonthlyInvestment:
                    currentMonthlyInvestment,
                requiredMonthlyInvestment:
                    requiredMonthlyInvestment,
                onTrack: viewModel.onTrack,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              DifferenceCard(
                onTrack: viewModel.onTrack,
                difference: displayedDifference,
                remainingPortfolio: remainingPortfolio,
                targetAge: viewModel.targetAge,
              ),
              const SizedBox(
                height: DesignTokens.spacingMd,
              ),
              MilestoneCard(
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