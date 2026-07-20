enum InsightType {
  excellent,
  good,
 neutral,
  warning,
}

enum InsightImpact {
  high,
  medium,
  low,
}

class BloomInsightResult {
  final InsightType type;
  final InsightImpact impact;

  final String title;
  final String message;
  final String recommendation;

  const BloomInsightResult({
    required this.type,
    required this.impact,
    required this.title,
    required this.message,
    required this.recommendation,
  });
}

class BloomInsightEngine {
  const BloomInsightEngine._();

  static BloomInsightResult generate({
    required double monthlyInvestmentDifference,
    required double dailyInvestmentDifference,
    required double portfolioDifference,
    required int freedomYearsGained,
  }) {
    // --------------------------------------------------
    // Excelente decisão
    // --------------------------------------------------

    if (freedomYearsGained >= 3 &&
        portfolioDifference >= 100000) {
      return BloomInsightResult(
        type: InsightType.excellent,
        impact: InsightImpact.high,
        title: 'Excelente decisão',
        message:
            'Um pequeno aumento do investimento produz um impacto muito significativo no teu plano financeiro.',

        recommendation:
            'Investir cerca de ${_currency(dailyInvestmentDifference)} por dia poderá antecipar a tua independência financeira em '
            '$freedomYearsGained anos e aumentar o património final em ${_currency(portfolioDifference)}.',
      );
    }

    // --------------------------------------------------
    // Boa melhoria
    // --------------------------------------------------

    if (freedomYearsGained > 0 &&
        portfolioDifference > 0) {
      return BloomInsightResult(
        type: InsightType.good,
        impact: InsightImpact.medium,
        title: 'Boa melhoria',
        message:
            'O cenário simulado melhora o plano oficial com um esforço financeiro adicional controlado.',

        recommendation:
            'Mantém este cenário em consideração. Pequenos aumentos do investimento mensal podem produzir ganhos relevantes no longo prazo.',
      );
    }

    // --------------------------------------------------
    // Sem impacto relevante
    // --------------------------------------------------

    if (freedomYearsGained == 0 &&
        portfolioDifference.abs() < 5000) {
      return const BloomInsightResult(
        type: InsightType.neutral,
        impact: InsightImpact.low,
        title: 'Impacto reduzido',
        message:
            'As alterações efetuadas praticamente não modificam o resultado final.',

        recommendation:
            'Experimenta alterar o investimento mensal, a idade objetivo ou ambos para perceberes melhor o impacto das diferentes estratégias.',
      );
    }

    // --------------------------------------------------
    // Cenário menos eficiente
    // --------------------------------------------------

    return const BloomInsightResult(
      type: InsightType.warning,
      impact: InsightImpact.medium,
      title: 'Vale a pena rever este cenário',
      message:
          'O esforço financeiro adicional não está a gerar um benefício proporcional.',

      recommendation:
          'Antes de investir mais, considera rever o horizonte temporal ou a estratégia de investimento. Em alguns casos, pequenas alterações nesses parâmetros produzem melhores resultados.',
    );
  }

  static String _currency(double value) {
    final String digits =
        value.abs().toStringAsFixed(0).replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => '.',
    );

    return '$digits €';
  }
}