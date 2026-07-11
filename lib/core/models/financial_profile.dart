class FinancialProfile {
  final double currentPortfolio;
  final double monthlyInvestment;
  final double desiredMonthlyIncomeToday;
  final int targetFinancialIndependenceAge;
  final double expectedAnnualReturn;
  final double expectedInflation;
  final double safeWithdrawalRate;

  const FinancialProfile({
    required this.currentPortfolio,
    required this.monthlyInvestment,
    required this.desiredMonthlyIncomeToday,
    required this.targetFinancialIndependenceAge,
    this.expectedAnnualReturn = 8.0,
    this.expectedInflation = 2.0,
    this.safeWithdrawalRate = 4.0,
  });

  FinancialProfile copyWith({
    double? currentPortfolio,
    double? monthlyInvestment,
    double? desiredMonthlyIncomeToday,
    int? targetFinancialIndependenceAge,
    double? expectedAnnualReturn,
    double? expectedInflation,
    double? safeWithdrawalRate,
  }) {
    return FinancialProfile(
      currentPortfolio: currentPortfolio ?? this.currentPortfolio,
      monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
      desiredMonthlyIncomeToday:
          desiredMonthlyIncomeToday ?? this.desiredMonthlyIncomeToday,
      targetFinancialIndependenceAge:
          targetFinancialIndependenceAge ??
          this.targetFinancialIndependenceAge,
      expectedAnnualReturn:
          expectedAnnualReturn ?? this.expectedAnnualReturn,
      expectedInflation: expectedInflation ?? this.expectedInflation,
      safeWithdrawalRate:
          safeWithdrawalRate ?? this.safeWithdrawalRate,
    );
  }
}