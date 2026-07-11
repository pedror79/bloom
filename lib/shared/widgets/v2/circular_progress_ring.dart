import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class CircularProgressRing extends StatelessWidget {
  final double progress;
  final String value;
  final String? label;
  final double size;
  final double strokeWidth;

  const CircularProgressRing({
    super.key,
    required this.progress,
    required this.value,
    this.label,
    this.size = DesignTokens.progressRingSize,
    this.strokeWidth = DesignTokens.progressRingStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedProgress = progress.clamp(0.0, 1.0).toDouble();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _CircularProgressRingPainter(
              progress: normalizedProgress,
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 36,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.2,
                  color: DesignTokens.textPrimary,
                ),
              ),
              if (label != null) ...[
                const SizedBox(height: DesignTokens.spacingXs),
                Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: DesignTokens.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  const _CircularProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        (math.min(size.width, size.height) - strokeWidth) / 2;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final trackPaint = Paint()
      ..color = DesignTokens.progressTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = DesignTokens.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      0,
      math.pi * 2,
      false,
      trackPaint,
    );

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _CircularProgressRingPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}