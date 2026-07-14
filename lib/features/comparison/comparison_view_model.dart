import '../../models/simulation_scenario.dart';
import '../../models/user_profile.dart';
import '../dashboard/dashboard_view_model.dart';

class ComparisonViewModel {
  final UserProfile officialProfile;
  final UserProfile simulatedProfile;

  final DashboardViewModel official;
  final DashboardViewModel simulated;

  final double monthlyInvestmentDifference;
  final double dailyInvestmentDifference;
  final double yearlyInvestmentDifference;

  final double portfolioDifference;
  final double portfolioDifferencePercent;

  final int targetAgeDifference;
  final int freedomYearsGained;

  final String bloomInsight;

  const ComparisonViewModel({
    required this.officialProfile,
    required this.simulatedProfile,
    required this.official,
    required this.simulated,
    required this.monthlyInvestmentDifference,
    required this.dailyInvestmentDifference,
    required this.yearlyInvestmentDifference,
    required this.portfolioDifference,
    required this.portfolioDifferencePercent,
    required this.targetAgeDifference,
    required this.freedomYearsGained,
    required this.bloomInsight,
  });

  factory ComparisonViewModel.from({
    required UserProfile profile,
    required SimulationScenario scenario,
  }) {
    final UserProfile simulatedProfile = profile.copyWith(
      monthlyInvestment: scenario.monthlyInvestment,
      targetFinancialIndependenceAge: scenario.targetAge,
    );

    final DashboardViewModel official =
        DashboardViewModel.fromProfile(profile);

    final DashboardViewModel simulated =
        DashboardViewModel.fromProfile(simulatedProfile);

    final double officialMonthlyInvestment =
        (profile.monthlyInvestment ?? 0).toDouble();

    final double simulatedMonthlyInvestment =
        (simulatedProfile.monthlyInvestment ?? 0).toDouble();

    final double monthlyInvestmentDifference =
        simulatedMonthlyInvestment - officialMonthlyInvestment;

    final double dailyInvestmentDifference =
        monthlyInvestmentDifference * 12 / 365;

    final double yearlyInvestmentDifference =
        monthlyInvestmentDifference * 12;

    final double portfolioDifference =
        simulated.projectedPortfolio.toDouble() -
            official.projectedPortfolio.toDouble();

    final double officialProjectedPortfolio =
        official.projectedPortfolio.toDouble();

    final double portfolioDifferencePercent =
        officialProjectedPortfolio == 0
            ? 0
            : portfolioDifference /
                officialProjectedPortfolio *
                100;

    final int targetAgeDifference =
        simulated.targetAge - official.targetAge;

    final int freedomYearsGained =
        official.targetAge - simulated.targetAge;

    final String bloomInsight = _buildBloomInsight(
      monthlyInvestmentDifference:
          monthlyInvestmentDifference,
      dailyInvestmentDifference:
          dailyInvestmentDifference,
      portfolioDifference: portfolioDifference,
      freedomYearsGained: freedomYearsGained,
    );

    return ComparisonViewModel(
      officialProfile: profile,
      simulatedProfile: simulatedProfile,
      official: official,
      simulated: simulated,
      monthlyInvestmentDifference:
          monthlyInvestmentDifference,
      dailyInvestmentDifference:
          dailyInvestmentDifference,
      yearlyInvestmentDifference:
          yearlyInvestmentDifference,
      portfolioDifference: portfolioDifference,
      portfolioDifferencePercent:
          portfolioDifferencePercent,
      targetAgeDifference: targetAgeDifference,
      freedomYearsGained: freedomYearsGained,
      bloomInsight: bloomInsight,
    );
  }

  static String _buildBloomInsight({
    required double monthlyInvestmentDifference,
    required double dailyInvestmentDifference,
    required double portfolioDifference,
    required int freedomYearsGained,
  }) {
    if (monthlyInvestmentDifference == 0 &&
        freedomYearsGained == 0) {
      return 'O cenário simulado é igual ao teu Plano Oficial. '
          'Experimenta alterar o investimento mensal ou a idade objetivo.';
    }

    if (monthlyInvestmentDifference > 0 &&
        freedomYearsGained > 0) {
      return 'Ao investir mais '
          '${dailyInvestmentDifference.abs().toStringAsFixed(2)} € por dia, '
          'este cenário pode antecipar a tua liberdade financeira em '
          '$freedomYearsGained '
          '${freedomYearsGained == 1 ? 'ano' : 'anos'}.';
    }

    if (freedomYearsGained > 0) {
      return 'Este cenário pode antecipar a tua liberdade financeira em '
          '$freedomYearsGained '
          '${freedomYearsGained == 1 ? 'ano' : 'anos'}.';
    }

    if (portfolioDifference > 0) {
      return 'Este cenário aumenta o teu património projetado em '
          '${portfolioDifference.toStringAsFixed(0)} €.';
    }

    if (monthlyInvestmentDifference < 0) {
      return 'Este cenário reduz o investimento mensal em '
          '${monthlyInvestmentDifference.abs().toStringAsFixed(0)} €. '
          'Analisa o impacto no teu objetivo antes de decidir.';
    }

    if (freedomYearsGained < 0) {
      return 'Este cenário adia a tua liberdade financeira em '
          '${freedomYearsGained.abs()} '
          '${freedomYearsGained.abs() == 1 ? 'ano' : 'anos'}.';
    }

    return 'Este cenário altera o teu plano financeiro. '
        'Compara os resultados antes de tomar uma decisão.';
  }
}