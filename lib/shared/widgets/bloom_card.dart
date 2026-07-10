import 'package:flutter/material.dart';
import '../../core/constants/design_tokens.dart';

class BloomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const BloomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(
      DesignTokens.spacingMd,
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        border: Border.all(
          color: DesignTokens.border,
        ),
        boxShadow: DesignTokens.cardShadow,
      ),
      child: child,
    );

    if (onTap == null) {
      return card;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        DesignTokens.radiusLg,
      ),
      child: card,
    );
  }
}