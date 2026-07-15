import '../../models/user_profile.dart';
import '../constants/financial_constants.dart';
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
    final int currentMonth = calculationDate.month;

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
          month: currentMonth,
          age: currentAge + year,
          yearsElapsed: year,
          monthsElapsed:
              year * FinancialConstants.monthsPerYear,
          portfolio: projectedPortfolio,
        ),
      );
    }

    return timeline;
  }

  List<TimelinePoint> buildMonthlyTimeline({
    required UserProfile profile,
    DateTime? referenceDate,
  }) {
    final DateTime calculationDate =
        referenceDate ?? DateTime.now();

    final int currentAge = profile.age ?? 18;

    final int targetAge =
        profile.targetFinancialIndependenceAge ??
            currentAge + 20;

    final int totalYears =
        (targetAge - currentAge).clamp(0, 100);

    final int totalMonths =
        totalYears * FinancialConstants.monthsPerYear;

    final bloomUser =
        UserProfileMapper.toBloomUser(profile);

    final financialProfile =
        bloomUser.financialProfile;

    final List<TimelinePoint> timeline = [];

    for (
      int monthIndex = 0;
      monthIndex <= totalMonths;
      monthIndex++
    ) {
      final DateTime pointDate = DateTime(
        calculationDate.year,
        calculationDate.month + monthIndex,
      );

      final double projectedPortfolio =
          portfolioProjector.projectMonths(
        currentPortfolio:
            financialProfile.currentPortfolio,
        monthlyInvestment:
            financialProfile.monthlyInvestment,
        months: monthIndex,
        annualReturnRate:
            financialProfile.expectedAnnualReturn,
      );

      timeline.add(
        TimelinePoint(
          year: pointDate.year,
          month: pointDate.month,
          age: currentAge +
              monthIndex ~/
                  FinancialConstants.monthsPerYear,
          yearsElapsed: monthIndex ~/
              FinancialConstants.monthsPerYear,
          monthsElapsed: monthIndex,
          portfolio: projectedPortfolio,
        ),
      );
    }

    return timeline;
  }
}