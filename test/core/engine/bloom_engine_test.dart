import 'package:bloom_app/core/engine/projection_engine.dart';
import 'package:bloom_app/core/models/bloom_user.dart';
import 'package:bloom_app/core/models/financial_profile.dart';
import 'package:bloom_app/core/models/identity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const engine = ProjectionEngine();

  group('ProjectionEngine validation', () {
    test('accepts a valid financial plan', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 100000,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
        ),
      );

      expect(engine.isFinancialPlanValid(user), isTrue);
    });

    test('rejects a plan with an empty name', () {
      const user = BloomUser(
        identity: Identity(
          name: '   ',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 100000,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
        ),
      );

      expect(engine.isFinancialPlanValid(user), isFalse);
    });

    test('rejects a negative current portfolio', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: -1,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
        ),
      );

      expect(engine.isFinancialPlanValid(user), isFalse);
    });

    test('rejects a target age equal to the current age', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 100000,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 46,
        ),
      );

      expect(engine.isFinancialPlanValid(user), isFalse);
    });
  });

  group('ProjectionEngine inflation calculations', () {
    test('keeps the same income when inflation is zero', () {
      final result = engine.adjustMonthlyIncomeForInflation(
        monthlyIncomeToday: 3000,
        yearsUntilTarget: 20,
        annualInflationRate: 0,
      );

      expect(result, closeTo(3000, 0.01));
    });

    test('adjusts monthly income for inflation', () {
      final result = engine.adjustMonthlyIncomeForInflation(
        monthlyIncomeToday: 3000,
        yearsUntilTarget: 20,
        annualInflationRate: 2,
      );

      expect(result, closeTo(4457.84, 0.01));
    });

    test('rejects a negative inflation rate', () {
      expect(
        () => engine.adjustMonthlyIncomeForInflation(
          monthlyIncomeToday: 3000,
          yearsUntilTarget: 20,
          annualInflationRate: -1,
        ),
        throwsArgumentError,
      );
    });
  });

  group('ProjectionEngine FIRE calculations', () {
    test('calculates FIRE number without inflation', () {
      final result = engine.calculateFireNumber(
        monthlyIncomeToday: 3000,
        yearsUntilTarget: 0,
        annualInflationRate: 0,
        safeWithdrawalRate: 4,
      );

      expect(result, closeTo(900000, 0.01));
    });

    test('calculates inflation-adjusted FIRE number', () {
      final result = engine.calculateFireNumber(
        monthlyIncomeToday: 3000,
        yearsUntilTarget: 20,
        annualInflationRate: 2,
        safeWithdrawalRate: 4,
      );

      expect(result, closeTo(1337352.66, 0.1));
    });

    test('rejects an invalid safe withdrawal rate', () {
      expect(
        () => engine.calculateFireNumber(
          monthlyIncomeToday: 3000,
          yearsUntilTarget: 20,
          annualInflationRate: 2,
          safeWithdrawalRate: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('ProjectionEngine complete projection', () {
    test('calculates a complete projection result', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 100000,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
          expectedAnnualReturn: 8,
          expectedInflation: 2,
          safeWithdrawalRate: 4,
        ),
      );

      final result = engine.calculate(user);

      expect(result.yearsRemaining, 14);
      expect(result.targetAge, 60);
      expect(result.targetYear, DateTime.now().year + 14);

      expect(
        result.fireNumber,
        closeTo(1187530.89, 0.01),
      );

      expect(
        result.projectedPortfolio,
        closeTo(444262.15, 0.01),
      );

      expect(
        result.progress,
        closeTo(0.3741, 0.0001),
      );

      expect(result.onTrack, isFalse);

      expect(
        result.requiredMonthlyInvestment,
        closeTo(2968.63, 0.01),
      );
    });

    test('marks the plan as on track when the target is reached', () {
      const user = BloomUser(
        identity: Identity(
          name: 'Pedro',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 1500000,
          monthlyInvestment: 0,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
          expectedAnnualReturn: 8,
          expectedInflation: 2,
          safeWithdrawalRate: 4,
        ),
      );

      final result = engine.calculate(user);

      expect(result.onTrack, isTrue);
      expect(result.progress, 1);
      expect(result.requiredMonthlyInvestment, 0);
      expect(
        result.projectedPortfolio,
        greaterThanOrEqualTo(result.fireNumber),
      );
    });

    test('rejects an invalid plan when calculating a projection', () {
      const user = BloomUser(
        identity: Identity(
          name: '',
          age: 46,
        ),
        financialProfile: FinancialProfile(
          currentPortfolio: 100000,
          monthlyInvestment: 500,
          desiredMonthlyIncomeToday: 3000,
          targetFinancialIndependenceAge: 60,
        ),
      );

      expect(
        () => engine.calculate(user),
        throwsArgumentError,
      );
    });
  });
}