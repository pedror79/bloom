import 'package:bloom_app/core/engine/calculators/portfolio_projector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const projector = PortfolioProjector();

  group('PortfolioProjector', () {
    test('returns the current portfolio when the horizon is zero', () {
      final result = projector.project(
        currentPortfolio: 100000,
        monthlyInvestment: 500,
        years: 0,
        annualReturnRate: 8,
      );

      expect(result, closeTo(100000, 0.01));
    });

    test('projects a portfolio with zero annual return', () {
      final result = projector.project(
        currentPortfolio: 10000,
        monthlyInvestment: 500,
        years: 2,
        annualReturnRate: 0,
      );

      expect(result, closeTo(22000, 0.01));
    });

    test('projects a portfolio with monthly compounding', () {
      final result = projector.project(
        currentPortfolio: 100000,
        monthlyInvestment: 500,
        years: 14,
        annualReturnRate: 8,
      );

      expect(result, closeTo(444262.15, 0.1));
    });

    test('adds the monthly investment at the end of each month', () {
      final result = projector.project(
        currentPortfolio: 0,
        monthlyInvestment: 1000,
        years: 1,
        annualReturnRate: 12,
      );

      expect(result, closeTo(12646.50, 0.1));
    });

    test('rejects a negative current portfolio', () {
      expect(
        () => projector.project(
          currentPortfolio: -1,
          monthlyInvestment: 500,
          years: 10,
          annualReturnRate: 8,
        ),
        throwsArgumentError,
      );
    });

    test('rejects a negative monthly investment', () {
      expect(
        () => projector.project(
          currentPortfolio: 10000,
          monthlyInvestment: -1,
          years: 10,
          annualReturnRate: 8,
        ),
        throwsArgumentError,
      );
    });

    test('rejects a negative horizon', () {
      expect(
        () => projector.project(
          currentPortfolio: 10000,
          monthlyInvestment: 500,
          years: -1,
          annualReturnRate: 8,
        ),
        throwsArgumentError,
      );
    });

    test('rejects an annual return equal to minus one hundred percent', () {
      expect(
        () => projector.project(
          currentPortfolio: 10000,
          monthlyInvestment: 500,
          years: 10,
          annualReturnRate: -100,
        ),
        throwsArgumentError,
      );
    });
  });
}