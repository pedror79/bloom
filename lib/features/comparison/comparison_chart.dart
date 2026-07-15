import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import 'comparison_chart_point.dart';

class ComparisonChart extends StatelessWidget {
  final List<ComparisonChartPoint> points;

  const ComparisonChart({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    if (points.length < 2) {
      return const _EmptyComparisonChart();
    }

    final List<ComparisonChartPoint> orderedPoints =
        List<ComparisonChartPoint>.from(points)
          ..sort(
            (
              ComparisonChartPoint first,
              ComparisonChartPoint second,
            ) {
              return first.timelinePosition.compareTo(
                second.timelinePosition,
              );
            },
          );

    final List<FlSpot> officialSpots =
        orderedPoints.map((ComparisonChartPoint point) {
      return FlSpot(
        point.timelinePosition,
        point.officialPortfolio,
      );
    }).toList();

    final List<FlSpot> simulatedSpots =
        orderedPoints.map((ComparisonChartPoint point) {
      return FlSpot(
        point.timelinePosition,
        point.simulatedPortfolio,
      );
    }).toList();

    final double minimumX =
        orderedPoints.first.timelinePosition;

    final double maximumX =
        orderedPoints.last.timelinePosition;

    final double maximumPortfolio =
        _calculateMaximumPortfolio(orderedPoints);

    final double maximumYAxis =
        _calculateMaximumYAxis(maximumPortfolio);

    final double horizontalInterval =
        _calculateHorizontalInterval(maximumYAxis);

    final Set<int> visibleYears =
        _buildVisibleYears(orderedPoints);

    final bool portfoliosAreEqual =
        _portfoliosAreEqual(orderedPoints);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.borderSoft,
        ),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolução do património',
            style: TextStyle(
              fontSize: 17,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: DesignTokens.textPrimary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingXs,
          ),
          const Text(
            'Compara a projeção do Plano Oficial com o cenário simulado.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: DesignTokens.textSecondary,
            ),
          ),
          const SizedBox(
            height: DesignTokens.spacingMd,
          ),
          const _ChartLegend(),
          if (portfoliosAreEqual) ...[
            const SizedBox(
              height: DesignTokens.spacingSm,
            ),
            const _EqualScenarioMessage(),
          ],
          const SizedBox(
            height: DesignTokens.spacingLg,
          ),
          SizedBox(
            height: 270,
            child: LineChart(
              LineChartData(
                minX: minimumX,
                maxX: maximumX,
                minY: 0,
                maxY: maximumYAxis,
                clipData: const FlClipData.all(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: horizontalInterval,
                  getDrawingHorizontalLine: (
                    double value,
                  ) {
                    return FlLine(
                      color: DesignTokens.borderSoft.withValues(
                        alpha: 0.75,
                      ),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: horizontalInterval,
                      getTitlesWidget: (
                        double value,
                        TitleMeta meta,
                      ) {
                        if (value < 0 ||
                            value > maximumYAxis) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: DesignTokens.spacingXs,
                          ),
                          child: Text(
                            _formatCompactCurrency(value),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              color: DesignTokens.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: 1,
                      getTitlesWidget: (
                        double value,
                        TitleMeta meta,
                      ) {
                        final int year = value.round();

                        if ((value - year).abs() > 0.04 ||
                            !visibleYears.contains(year)) {
                          return const SizedBox.shrink();
                        }

                        return SideTitleWidget(
                          meta: meta,
                          space: DesignTokens.spacingXs,
                          child: Text(
                            '$year',
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.2,
                              fontWeight: FontWeight.w500,
                              color: DesignTokens.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingSm,
                    ),
                    getTooltipColor: (
                      LineBarSpot touchedSpot,
                    ) {
                      return DesignTokens.textPrimary;
                    },
                    getTooltipItems: (
                      List<LineBarSpot> touchedSpots,
                    ) {
                      return touchedSpots.map(
                        (LineBarSpot spot) {
                          final bool isSimulated =
                              spot.barIndex == 0;

                          final String scenario = isSimulated
                              ? 'Cenário Simulado'
                              : 'Plano Oficial';

                          return LineTooltipItem(
                            '$scenario\n'
                            '${_formatCurrency(spot.y)}',
                            TextStyle(
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                              color: isSimulated
                                  ? DesignTokens.primaryLight
                                  : DesignTokens.surface,
                            ),
                          );
                        },
                      ).toList();
                    },
                  ),
                  getTouchedSpotIndicator: (
                    LineChartBarData barData,
                    List<int> spotIndexes,
                  ) {
                    return spotIndexes.map(
                      (int index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: DesignTokens.textSecondary
                                .withValues(
                              alpha: 0.30,
                            ),
                            strokeWidth: 1,
                            dashArray: const [4, 4],
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (
                              FlSpot spot,
                              double percent,
                              LineChartBarData bar,
                              int index,
                            ) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: bar.color ??
                                    DesignTokens.primary,
                                strokeWidth: 2,
                                strokeColor:
                                    DesignTokens.surface,
                              );
                            },
                          ),
                        );
                      },
                    ).toList();
                  },
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: simulatedSpots,
                    isCurved: true,
                    curveSmoothness: 0.08,
                    preventCurveOverShooting: true,
                    preventCurveOvershootingThreshold: 5,
                    color: DesignTokens.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    isStrokeJoinRound: true,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (
                        FlSpot spot,
                        LineChartBarData barData,
                      ) {
                        return spot.x ==
                            simulatedSpots.last.x;
                      },
                      getDotPainter: (
                        FlSpot spot,
                        double percent,
                        LineChartBarData bar,
                        int index,
                      ) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: DesignTokens.primary,
                          strokeWidth: 2,
                          strokeColor: DesignTokens.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          DesignTokens.primary.withValues(
                            alpha: 0.16,
                          ),
                          DesignTokens.primary.withValues(
                            alpha: 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                  LineChartBarData(
                    spots: officialSpots,
                    isCurved: true,
                    curveSmoothness: 0.08,
                    preventCurveOverShooting: true,
                    preventCurveOvershootingThreshold: 5,
                    color: DesignTokens.textSecondary,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    isStrokeJoinRound: true,
                    dashArray: const [8, 5],
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (
                        FlSpot spot,
                        LineChartBarData barData,
                      ) {
                        return spot.x ==
                            officialSpots.last.x;
                      },
                      getDotPainter: (
                        FlSpot spot,
                        double percent,
                        LineChartBarData bar,
                        int index,
                      ) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: DesignTokens.textSecondary,
                          strokeWidth: 2,
                          strokeColor: DesignTokens.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                  ),
                ],
              ),
              duration: const Duration(
                milliseconds: 750,
              ),
              curve: Curves.easeOutCubic,
            ),
          ),
        ],
      ),
    );
  }

  static double _calculateMaximumPortfolio(
    List<ComparisonChartPoint> points,
  ) {
    double maximumPortfolio = 0;

    for (final ComparisonChartPoint point in points) {
      maximumPortfolio = math.max(
        maximumPortfolio,
        point.officialPortfolio,
      );

      maximumPortfolio = math.max(
        maximumPortfolio,
        point.simulatedPortfolio,
      );
    }

    return maximumPortfolio;
  }

  static double _calculateMaximumYAxis(
    double maximumPortfolio,
  ) {
    if (maximumPortfolio <= 0) {
      return 10000;
    }

    final double paddedMaximum =
        maximumPortfolio * 1.15;

    final double interval =
        _calculateHorizontalInterval(paddedMaximum);

    return (paddedMaximum / interval).ceil() * interval;
  }

  static double _calculateHorizontalInterval(
    double maximumValue,
  ) {
    if (maximumValue <= 10000) {
      return 2500;
    }

    if (maximumValue <= 25000) {
      return 5000;
    }

    if (maximumValue <= 50000) {
      return 10000;
    }

    if (maximumValue <= 100000) {
      return 20000;
    }

    if (maximumValue <= 250000) {
      return 50000;
    }

    if (maximumValue <= 500000) {
      return 100000;
    }

    if (maximumValue <= 1000000) {
      return 200000;
    }

    if (maximumValue <= 2500000) {
      return 500000;
    }

    if (maximumValue <= 5000000) {
      return 1000000;
    }

    return 2000000;
  }

  static Set<int> _buildVisibleYears(
    List<ComparisonChartPoint> points,
  ) {
    final int firstYear = points.first.year;
    final int lastYear = points.last.year;
    final int totalYears = lastYear - firstYear;

    if (totalYears <= 5) {
      return {
        for (
          int year = firstYear;
          year <= lastYear;
          year++
        )
          year,
      };
    }

    const int desiredLabelCount = 5;

    final Set<int> labels = {
      firstYear,
      lastYear,
    };

    for (
      int index = 1;
      index < desiredLabelCount - 1;
      index++
    ) {
      final double progress =
          index / (desiredLabelCount - 1);

      final int year =
          firstYear + (totalYears * progress).round();

      labels.add(year);
    }

    return labels;
  }

  static bool _portfoliosAreEqual(
    List<ComparisonChartPoint> points,
  ) {
    const double tolerance = 0.01;

    for (final ComparisonChartPoint point in points) {
      final double difference =
          (point.officialPortfolio -
                  point.simulatedPortfolio)
              .abs();

      if (difference > tolerance) {
        return false;
      }
    }

    return true;
  }

  static String _formatCompactCurrency(double value) {
    final double absoluteValue = value.abs();

    if (absoluteValue >= 1000000) {
      final double millions = value / 1000000;

      return '${_removeTrailingZero(millions)}M €';
    }

    if (absoluteValue >= 1000) {
      final double thousands = value / 1000;

      return '${_removeTrailingZero(thousands)}k €';
    }

    return '${value.toStringAsFixed(0)} €';
  }

  static String _formatCurrency(double value) {
    final String digits =
        value.abs().toStringAsFixed(0);

    final String formattedDigits =
        digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match match) => '.',
    );

    final String sign = value < 0 ? '-' : '';

    return '$sign$formattedDigits €';
  }

  static String _removeTrailingZero(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(1);
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: DesignTokens.spacingLg,
      runSpacing: DesignTokens.spacingSm,
      children: [
        _ChartLegendItem(
          color: DesignTokens.textSecondary,
          label: 'Plano Oficial',
          dashed: true,
        ),
        _ChartLegendItem(
          color: DesignTokens.primary,
          label: 'Cenário Simulado',
          dashed: false,
        ),
      ],
    );
  }
}

class _ChartLegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool dashed;

  const _ChartLegendItem({
    required this.color,
    required this.label,
    required this.dashed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 22,
          height: 4,
          child: Row(
            children: dashed
                ? [
                    _LegendSegment(color: color),
                    const SizedBox(width: 3),
                    _LegendSegment(color: color),
                    const SizedBox(width: 3),
                    _LegendSegment(color: color),
                  ]
                : [
                    Expanded(
                      child: Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusLg,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
        const SizedBox(
          width: DesignTokens.spacingXs,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _LegendSegment extends StatelessWidget {
  final Color color;

  const _LegendSegment({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            DesignTokens.radiusLg,
          ),
        ),
      ),
    );
  }
}

class _EqualScenarioMessage extends StatelessWidget {
  const _EqualScenarioMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.primaryLight,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusMd,
        ),
      ),
      child: const Text(
        'As duas projeções são iguais. As linhas estão sobrepostas.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          height: 1.3,
          fontWeight: FontWeight.w600,
          color: DesignTokens.primary,
        ),
      ),
    );
  }
}

class _EmptyComparisonChart extends StatelessWidget {
  const _EmptyComparisonChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      padding: const EdgeInsets.all(
        DesignTokens.spacingLg,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.borderSoft,
        ),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: const Center(
        child: Text(
          'Ainda não existem dados suficientes para apresentar o gráfico.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: DesignTokens.textSecondary,
          ),
        ),
      ),
    );
  }
}