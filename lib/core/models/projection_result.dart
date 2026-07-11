class ProjectionResult {
  final double fireNumber;

  final double projectedPortfolio;

  final int targetYear;

  final int targetAge;

  final int yearsRemaining;

  final double progress;

  final bool onTrack;

  final double requiredMonthlyInvestment;

  const ProjectionResult({
    required this.fireNumber,
    required this.projectedPortfolio,
    required this.targetYear,
    required this.targetAge,
    required this.yearsRemaining,
    required this.progress,
    required this.onTrack,
    required this.requiredMonthlyInvestment,
  });
}