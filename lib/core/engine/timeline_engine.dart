import '../../models/user_profile.dart';
import '../mappers/user_profile_mapper.dart';
import '../models/timeline_point.dart';
import 'calculators/portfolio_projector.dart';

class TimelineEngine {
  final PortfolioProjector portfolioProjector;

  const TimelineEngine({
    this.portfolioProjector = const PortfolioProjector(),
  });

  List<TimelinePoint> buildTimeline({
    required UserProfile profile,
    DateTime? referenceDate,
  }) {
    final DateTime calculationDate =
        referenceDate ?? DateTime.now();

    final int currentYear = calculationDate.year;

    final int currentAge = profile.age ?? 18;

    final int targetAge =
        profile.targetFinancialIndependenceAge ??
            currentAge + 20;

    final int totalYears =
        (targetAge - currentAge).clamp(0, 100);

    final bloomUser =
        UserProfileMapper.toBloomUser(profile);

    final financialProfile =
        bloomUser.financialProfile;

    final List<TimelinePoint> timeline = [];

    for (int year = 0; year <= totalYears; year++) {
      final double projectedPortfolio =
          portfolioProjector.project(
        currentPortfolio:
            financialProfile.currentPortfolio,
        monthlyInvestment:
            financialProfile.monthlyInvestment,
        years: year,
        annualReturnRate:
            financialProfile.expectedAnnualReturn,
      );

      timeline.add(
        TimelinePoint(
          year: currentYear + year,
          age: currentAge + year,
          yearsElapsed: year,
          portfolio: projectedPortfolio,
        ),
      );
    }

    return timeline;
  }
}