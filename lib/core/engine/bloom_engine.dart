import '../models/bloom_user.dart';

class BloomEngine {
  const BloomEngine();

  int calculateYearsUntilRetirement(BloomUser user) {
    final yearsRemaining =
        user.financialProfile.retirementAge - user.identity.age;

    if (yearsRemaining < 0) {
      return 0;
    }

    return yearsRemaining;
  }

  bool isUserValid(BloomUser user) {
    return user.identity.name.trim().isNotEmpty &&
        user.identity.age > 0 &&
        user.financialProfile.monthlyInvestment >= 0 &&
        user.financialProfile.retirementAge >= user.identity.age;
  }
}