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
}