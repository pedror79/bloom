import '../../models/user_profile.dart';
import '../models/bloom_user.dart';
import '../models/financial_profile.dart';
import '../models/identity.dart';

class UserProfileMapper {
  const UserProfileMapper();

  BloomUser? toBloomUser(UserProfile profile) {
    final name = profile.name.trim();
    final age = profile.age;
    final monthlyInvestment = profile.monthlyInvestment;
    final retirementAge = profile.retirementAge;

    if (name.isEmpty ||
        age == null ||
        monthlyInvestment == null ||
        retirementAge == null) {
      return null;
    }

    return BloomUser(
      identity: Identity(
        name: name,
        age: age,
      ),
      financialProfile: FinancialProfile(
        monthlyInvestment: monthlyInvestment,
        retirementAge: retirementAge,
      ),
    );
  }
}