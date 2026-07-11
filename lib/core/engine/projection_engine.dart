import '../constants/financial_constants.dart';
import '../models/bloom_user.dart';
import '../models/projection_result.dart';
import 'calculators/fire_calculator.dart';
import 'calculators/portfolio_projector.dart';
import 'calculators/required_monthly_investment_calculator.dart';

class ProjectionEngine {
  final FireCalculator fireCalculator;
  final PortfolioProjector portfolioProjector;
  final RequiredMonthlyInvestmentCalculator
      requiredMonthlyInvestmentCalculator;

  const ProjectionEngine({
    this.fireCalculator = const FireCalculator(),
    this.portfolioProjector = const PortfolioProjector(),
    this.requiredMonthlyInvestmentCalculator =
        const RequiredMonthlyInvestmentCalculator(),
  });

  ProjectionResult calculate(BloomUser user) {
    if (!isFinancialPlanValid(user)) {
      throw ArgumentError.value(
        user,
        'user',
        'O plano financeiro contém dados inválidos.',
      );
    }

    final identity = user.identity;
    final profile = user.financialProfile;

    final yearsRemaining =
        profile.targetFinancialIndependenceAge - identity.age;

    final fireNumber = fireCalculator.calculate(
      monthlyIncomeToday: profile.desiredMonthlyIncomeToday,
      yearsUntilTarget: yearsRemaining,
      annualInflationRate: profile.expectedInflation,
      safeWithdrawalRate: profile.safeWithdrawalRate,
    );

    final projectedPortfolio = portfolioProjector.project(
      currentPortfolio: profile.currentPortfolio,
      monthlyInvestment: profile.monthlyInvestment,
      years: yearsRemaining,
      annualReturnRate: profile.expectedAnnualReturn,
    );

    final requiredMonthlyInvestment =
        requiredMonthlyInvestmentCalculator.calculate(
      currentPortfolio: profile.currentPortfolio,
      targetPortfolio: fireNumber,
      years: yearsRemaining,
      annualReturnRate: profile.expectedAnnualReturn,
    );

    final progress =
        (projectedPortfolio / fireNumber).clamp(0.0, 1.0).toDouble();

    final onTrack = projectedPortfolio >= fireNumber;

    final targetYear = DateTime.now().year + yearsRemaining;

    return ProjectionResult(
      fireNumber: fireNumber,
      projectedPortfolio: projectedPortfolio,
      targetYear: targetYear,
      targetAge: profile.targetFinancialIndependenceAge,
      yearsRemaining: yearsRemaining,
      progress: progress,
      onTrack: onTrack,
      requiredMonthlyInvestment: requiredMonthlyInvestment,
    );
  }

  bool isFinancialPlanValid(BloomUser user) {
    final profile = user.financialProfile;

    return user.identity.name.trim().isNotEmpty &&
        user.identity.age > 0 &&
        profile.currentPortfolio >= 0 &&
        profile.monthlyInvestment >= 0 &&
        profile.desiredMonthlyIncomeToday > 0 &&
        profile.targetFinancialIndependenceAge > user.identity.age &&
        profile.targetFinancialIndependenceAge <=
            FinancialConstants.maximumProjectionAge &&
        profile.expectedAnnualReturn > -FinancialConstants.percent &&
        profile.expectedInflation >= 0 &&
        profile.safeWithdrawalRate > 0 &&
        profile.safeWithdrawalRate <= FinancialConstants.percent;
  }

  double adjustMonthlyIncomeForInflation({
    required double monthlyIncomeToday,
    required int yearsUntilTarget,
    required double annualInflationRate,
  }) {
    return fireCalculator.adjustMonthlyIncomeForInflation(
      monthlyIncomeToday: monthlyIncomeToday,
      yearsUntilTarget: yearsUntilTarget,
      annualInflationRate: annualInflationRate,
    );
  }

  double calculateFireNumber({
    required double monthlyIncomeToday,
    required int yearsUntilTarget,
    required double annualInflationRate,
    required double safeWithdrawalRate,
  }) {
    return fireCalculator.calculate(
      monthlyIncomeToday: monthlyIncomeToday,
      yearsUntilTarget: yearsUntilTarget,
      annualInflationRate: annualInflationRate,
      safeWithdrawalRate: safeWithdrawalRate,
    );
  }
}