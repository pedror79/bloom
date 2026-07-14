class TimelinePoint {
  final int year;
  final int age;
  final int yearsElapsed;
  final double portfolio;

  const TimelinePoint({
    required this.year,
    required this.age,
    required this.yearsElapsed,
    required this.portfolio,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TimelinePoint &&
            other.year == year &&
            other.age == age &&
            other.yearsElapsed == yearsElapsed &&
            other.portfolio == portfolio;
  }

  @override
  int get hashCode {
    return Object.hash(
      year,
      age,
      yearsElapsed,
      portfolio,
    );
  }
}