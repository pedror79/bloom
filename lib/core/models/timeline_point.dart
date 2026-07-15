class TimelinePoint {
  final int year;
  final int month;

  final int age;
  final int yearsElapsed;
  final int monthsElapsed;

  final double portfolio;

  const TimelinePoint({
    required this.year,
    this.month = 1,
    required this.age,
    required this.yearsElapsed,
    this.monthsElapsed = 0,
    required this.portfolio,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TimelinePoint &&
            other.year == year &&
            other.month == month &&
            other.age == age &&
            other.yearsElapsed == yearsElapsed &&
            other.monthsElapsed == monthsElapsed &&
            other.portfolio == portfolio;
  }

  @override
  int get hashCode {
    return Object.hash(
      year,
      month,
      age,
      yearsElapsed,
      monthsElapsed,
      portfolio,
    );
  }
}