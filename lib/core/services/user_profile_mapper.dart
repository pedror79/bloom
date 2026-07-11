import '../../models/user_profile.dart';
import '../models/bloom_user.dart';
import '../models/financial_profile.dart';
import '../models/identity.dart';

class UserProfileMapper {
  const UserProfileMapper();

  BloomUser? toBloomUser(UserProfile profile) {
    final name = profile.name.trim();

    if (name.isEmpty ||
        profile.age == null ||
        profile.currentPortfolio == null ||
        profile.monthlyInvestment == null ||
        profile.targetFinancialIndependenceAge == null ||
        profile.desiredMonthlyIncomeToday == null) {
      return null;
    }

    return BloomUser(
      identity: Identity(
        name: name,
        age: profile.age!,
      ),
      financialProfile: FinancialProfile(
        currentPortfolio: profile.currentPortfolio!,
        monthlyInvestment: profile.monthlyInvestment!,
        desiredMonthlyIncomeToday:
            profile.desiredMonthlyIncomeToday!,
        targetFinancialIndependenceAge:
            profile.targetFinancialIndependenceAge!,
      ),
    );
  }
}