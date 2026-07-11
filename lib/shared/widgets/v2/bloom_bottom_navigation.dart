import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class BloomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BloomBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DesignTokens.bottomNavigationHeight,
      decoration: BoxDecoration(
        color: DesignTokens.navigationBackground,
        border: const Border(
          top: BorderSide(
            color: DesignTokens.borderSoft,
          ),
        ),
        boxShadow: DesignTokens.navigationShadow,
      ),
      child: Row(
        children: [
          _item(0, Icons.home_rounded),
          _item(1, Icons.insights_rounded),
          _item(2, Icons.calculate_rounded),
          _item(3, Icons.person_rounded),
        ],
      ),
    );
  }

  Widget _item(int index, IconData icon) {
    final selected = index == currentIndex;

    return Expanded(
      child: InkWell(
        onTap: () => onTap?.call(index),
        child: Center(
          child: AnimatedContainer(
            duration: DesignTokens.animationNormal,
            curve: DesignTokens.animationCurve,
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: selected
                  ? DesignTokens.primaryLight
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(
                DesignTokens.radiusMd,
              ),
            ),
            child: Icon(
              icon,
              size: 28,
              color: selected
                  ? DesignTokens.primary
                  : DesignTokens.navigationInactive,
            ),
          ),
        ),
      ),
    );
  }
}