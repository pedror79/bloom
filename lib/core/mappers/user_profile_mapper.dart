import '../../models/user_profile.dart';
import '../constants/financial_constants.dart';
import '../models/bloom_user.dart';
import '../models/financial_profile.dart';
import '../models/identity.dart';

class UserProfileMapper {
  const UserProfileMapper._();

  static BloomUser toBloomUser(UserProfile profile) {
    return BloomUser(
      identity: Identity(
        name: profile.name,
        age: profile.age ?? 0,
      ),
      financialProfile: FinancialProfile(
        currentPortfolio: profile.currentPortfolio ?? 0,
        monthlyInvestment: profile.monthlyInvestment ?? 0,
        desiredMonthlyIncomeToday:
            profile.desiredMonthlyIncomeToday ?? 0,
        targetFinancialIndependenceAge:
            profile.targetFinancialIndependenceAge ?? 0,
        expectedAnnualReturn:
            FinancialConstants.defaultAnnualReturn,
        expectedInflation:
            FinancialConstants.defaultInflation,
        safeWithdrawalRate:
            FinancialConstants.defaultSafeWithdrawalRate,
      ),
    );
  }
}