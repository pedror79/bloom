import 'dart:math';

import '../../constants/financial_constants.dart';

class RequiredMonthlyInvestmentCalculator {
  const RequiredMonthlyInvestmentCalculator();

  double calculate({
    required double currentPortfolio,
    required double targetPortfolio,
    required int years,
    required double annualReturnRate,
  }) {
    if (currentPortfolio < 0) {
      throw ArgumentError.value(
        currentPortfolio,
        'currentPortfolio',
        'O património atual não pode ser negativo.',
      );
    }

    if (targetPortfolio < 0) {
      throw ArgumentError.value(
        targetPortfolio,
        'targetPortfolio',
        'O património objetivo não pode ser negativo.',
      );
    }

    if (years <= 0) {
      throw ArgumentError.value(
        years,
        'years',
        'O horizonte temporal tem de ser superior a zero.',
      );
    }

    if (annualReturnRate <= -FinancialConstants.percent) {
      throw ArgumentError.value(
        annualReturnRate,
        'annualReturnRate',
        'A rentabilidade anual tem de ser superior a -100%.',
      );
    }

    final totalMonths = years * FinancialConstants.monthsPerYear;
    final annualReturnDecimal =
        annualReturnRate / FinancialConstants.percent;

    final monthlyReturnRate =
        pow(
          1 + annualReturnDecimal,
          1 / FinancialConstants.monthsPerYear,
        ).toDouble() -
        1;

    final projectedCurrentPortfolio =
        currentPortfolio *
        pow(1 + monthlyReturnRate, totalMonths).toDouble();

    if (projectedCurrentPortfolio >= targetPortfolio) {
      return 0;
    }

    final remainingTarget =
        targetPortfolio - projectedCurrentPortfolio;

    if (monthlyReturnRate == 0) {
      return remainingTarget / totalMonths;
    }

    final futureValueFactor =
        (pow(1 + monthlyReturnRate, totalMonths).toDouble() - 1) /
        monthlyReturnRate;

    return remainingTarget / futureValueFactor;
  }
}