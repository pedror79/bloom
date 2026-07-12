class UserProfile {
  String name;
  int? age;
  double? currentPortfolio;
  double? monthlyInvestment;
  int? targetFinancialIndependenceAge;
  double? desiredMonthlyIncomeToday;

  UserProfile({
    this.name = '',
    this.age,
    this.currentPortfolio,
    this.monthlyInvestment,
    this.targetFinancialIndependenceAge,
    this.desiredMonthlyIncomeToday,
  });

  UserProfile copyWith({
    String? name,
    int? age,
    double? currentPortfolio,
    double? monthlyInvestment,
    int? targetFinancialIndependenceAge,
    double? desiredMonthlyIncomeToday,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      currentPortfolio:
          currentPortfolio ?? this.currentPortfolio,
      monthlyInvestment:
          monthlyInvestment ?? this.monthlyInvestment,
      targetFinancialIndependenceAge:
          targetFinancialIndependenceAge ??
              this.targetFinancialIndependenceAge,
      desiredMonthlyIncomeToday:
          desiredMonthlyIncomeToday ??
              this.desiredMonthlyIncomeToday,
    );
  }
}