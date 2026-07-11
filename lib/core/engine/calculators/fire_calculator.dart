import 'dart:math';

import '../../constants/financial_constants.dart';

class FireCalculator {
  const FireCalculator();

  double adjustMonthlyIncomeForInflation({
    required double monthlyIncomeToday,
    required int yearsUntilTarget,
    required double annualInflationRate,
  }) {
    if (monthlyIncomeToday < 0) {
      throw ArgumentError.value(
        monthlyIncomeToday,
        'monthlyIncomeToday',
        'O rendimento mensal não pode ser negativo.',
      );
    }

    if (yearsUntilTarget < 0) {
      throw ArgumentError.value(
        yearsUntilTarget,
        'yearsUntilTarget',
        'O horizonte temporal não pode ser negativo.',
      );
    }

    if (annualInflationRate < 0) {
      throw ArgumentError.value(
        annualInflationRate,
        'annualInflationRate',
        'A inflação não pode ser negativa.',
      );
    }

    final inflationDecimal =
        annualInflationRate / FinancialConstants.percent;

    return monthlyIncomeToday *
        pow(1 + inflationDecimal, yearsUntilTarget);
  }

  double calculate({
    required double monthlyIncomeToday,
    required int yearsUntilTarget,
    required double annualInflationRate,
    required double safeWithdrawalRate,
  }) {
    if (safeWithdrawalRate <= 0 ||
        safeWithdrawalRate > FinancialConstants.percent) {
      throw ArgumentError.value(
        safeWithdrawalRate,
        'safeWithdrawalRate',
        'A taxa de levantamento deve estar entre 0 e 100.',
      );
    }

    final futureMonthlyIncome =
        adjustMonthlyIncomeForInflation(
      monthlyIncomeToday: monthlyIncomeToday,
      yearsUntilTarget: yearsUntilTarget,
      annualInflationRate: annualInflationRate,
    );

    final futureAnnualIncome =
        futureMonthlyIncome * FinancialConstants.monthsPerYear;

    final withdrawalRateDecimal =
        safeWithdrawalRate / FinancialConstants.percent;

    return futureAnnualIncome / withdrawalRateDecimal;
  }
}