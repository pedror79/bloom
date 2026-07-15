import 'dart:math';

import '../../constants/financial_constants.dart';

class PortfolioProjector {
  const PortfolioProjector();

  double project({
    required double currentPortfolio,
    required double monthlyInvestment,
    required int years,
    required double annualReturnRate,
  }) {
    if (years < 0) {
      throw ArgumentError.value(
        years,
        'years',
        'O horizonte temporal não pode ser negativo.',
      );
    }

    final int totalMonths =
        years * FinancialConstants.monthsPerYear;

    return projectMonths(
      currentPortfolio: currentPortfolio,
      monthlyInvestment: monthlyInvestment,
      months: totalMonths,
      annualReturnRate: annualReturnRate,
    );
  }

  double projectMonths({
    required double currentPortfolio,
    required double monthlyInvestment,
    required int months,
    required double annualReturnRate,
  }) {
    _validateInputs(
      currentPortfolio: currentPortfolio,
      monthlyInvestment: monthlyInvestment,
      months: months,
      annualReturnRate: annualReturnRate,
    );

    if (months == 0) {
      return currentPortfolio;
    }

    final double monthlyReturnRate =
        _monthlyReturnRate(annualReturnRate);

    double portfolio = currentPortfolio;

    for (int month = 0; month < months; month++) {
      portfolio *= 1 + monthlyReturnRate;
      portfolio += monthlyInvestment;
    }

    return portfolio;
  }

  void _validateInputs({
    required double currentPortfolio,
    required double monthlyInvestment,
    required int months,
    required double annualReturnRate,
  }) {
    if (currentPortfolio < 0) {
      throw ArgumentError.value(
        currentPortfolio,
        'currentPortfolio',
        'O património atual não pode ser negativo.',
      );
    }

    if (monthlyInvestment < 0) {
      throw ArgumentError.value(
        monthlyInvestment,
        'monthlyInvestment',
        'O investimento mensal não pode ser negativo.',
      );
    }

    if (months < 0) {
      throw ArgumentError.value(
        months,
        'months',
        'O horizonte temporal não pode ser negativo.',
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
        ).toDouble() -
        1;
  }
}