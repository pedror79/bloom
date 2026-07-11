import 'package:bloom_app/core/engine/bloom_engine.dart';
import 'package:bloom_app/core/models/bloom_user.dart';
import 'package:bloom_app/core/models/financial_profile.dart';
import 'package:bloom_app/core/models/identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = BloomEngine();

  group('BloomEngine', () {
    test('calculates the years remaining until retirement', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          monthlyInvestment: 500,
          retirementAge: 65,
        ),
      );

      final result = engine.calculateYearsUntilRetirement(user);

      expect(result, 19);
    });

    test('does not return a negative number of years', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 70,
        ),
        financialProfile: FinancialProfile(
          monthlyInvestment: 500,
          retirementAge: 65,
        ),
      );

      final result = engine.calculateYearsUntilRetirement(user);

      expect(result, 0);
    });

    test('accepts a valid user', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          monthlyInvestment: 500,
          retirementAge: 65,
        ),
      );

      expect(engine.isUserValid(user), isTrue);
    });

    test('rejects a user with an empty name', () {
      const user = BloomUser(
        identity: Identity(
          name: '   ',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          monthlyInvestment: 500,
          retirementAge: 65,
        ),
      );

      expect(engine.isUserValid(user), isFalse);
    });
  });
}