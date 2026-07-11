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

    if (years < 0) {
      throw ArgumentError.value(
        years,
        'years',
        'O horizonte temporal não pode ser negativo.',
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
        pow(1 + annualReturnDecimal, 1 / FinancialConstants.monthsPerYear) - 1;

    var portfolio = currentPortfolio;

    for (var month = 0; month < totalMonths; month++) {
      portfolio *= 1 + monthlyReturnRate;
      portfolio += monthlyInvestment;
    }

    return portfolio;
  }
}