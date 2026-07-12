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
    _validateInputs(
      currentPortfolio: currentPortfolio,
      targetPortfolio: targetPortfolio,
      years: years,
      annualReturnRate: annualReturnRate,
    );

    final int totalMonths =
        years * FinancialConstants.monthsPerYear;

    final double monthlyReturnRate =
        _monthlyReturnRate(annualReturnRate);

    final double projectedCurrentPortfolio =
        currentPortfolio *
            pow(
              1 + monthlyReturnRate,
              totalMonths,
            ).toDouble();

    if (projectedCurrentPortfolio >= targetPortfolio) {
      return 0;
    }

    final double remainingTarget =
        targetPortfolio - projectedCurrentPortfolio;

    if (monthlyReturnRate == 0) {
      return remainingTarget / totalMonths;
    }

    final double futureValueFactor =
        (pow(
                  1 + monthlyReturnRate,
                  totalMonths,
                ).toDouble() -
                1) /
            monthlyReturnRate;

    return remainingTarget / futureValueFactor;
  }

  void _validateInputs({
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

    if (annualReturnRate <=
        -FinancialConstants.percent) {
      throw ArgumentError.value(
        annualReturnRate,
        'annualReturnRate',
        'A rentabilidade anual tem de ser superior a -100%.',
      );
    }
  }

  double _monthlyReturnRate(
    double annualReturnRate,
  ) {
    final double annualReturnDecimal =
        annualReturnRate /
            FinancialConstants.percent;

    return pow(
          1 + annualReturnDecimal,
          1 / FinancialConstants.monthsPerYear,
        )
            .toDouble() -
        1;
  }
}