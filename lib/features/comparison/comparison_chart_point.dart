class ComparisonChartPoint {
  final double timelinePosition;

  final int year;
  final int month;
  final int monthsElapsed;

  final double officialPortfolio;
  final double simulatedPortfolio;

  const ComparisonChartPoint({
    required this.timelinePosition,
    required this.year,
    required this.month,
    required this.monthsElapsed,
    required this.officialPortfolio,
    required this.simulatedPortfolio,
  });
}