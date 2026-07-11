class FinancialProfile {
  final double monthlyInvestment;
  final int retirementAge;

  const FinancialProfile({
    required this.monthlyInvestment,
    required this.retirementAge,
  });

  FinancialProfile copyWith({
    double? monthlyInvestment,
    int? retirementAge,
  }) {
    return FinancialProfile(
      monthlyInvestment: monthlyInvestment ?? this.monthlyInvestment,
      retirementAge: retirementAge ?? this.retirementAge,
    );
  }
}