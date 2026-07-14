class SimulationScenario {
  final double monthlyInvestment;
  final int targetAge;

  const SimulationScenario({
    required this.monthlyInvestment,
    required this.targetAge,
  });

  SimulationScenario copyWith({
    double? monthlyInvestment,
    int? targetAge,
  }) {
    return SimulationScenario(
      monthlyInvestment:
          monthlyInvestment ?? this.monthlyInvestment,
      targetAge: targetAge ?? this.targetAge,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SimulationScenario &&
            other.monthlyInvestment == monthlyInvestment &&
            other.targetAge == targetAge;
  }

  @override
  int get hashCode {
    return Object.hash(
      monthlyInvestment,
      targetAge,
    );
  }
}