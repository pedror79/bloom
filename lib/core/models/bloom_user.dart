import 'financial_profile.dart';
import 'identity.dart';

class BloomUser {
  final Identity identity;
  final FinancialProfile financialProfile;

  const BloomUser({
    required this.identity,
    required this.financialProfile,
  });

  BloomUser copyWith({
    Identity? identity,
    FinancialProfile? financialProfile,
  }) {
    return BloomUser(
      identity: identity ?? this.identity,
      financialProfile: financialProfile ?? this.financialProfile,
    );
  }
}