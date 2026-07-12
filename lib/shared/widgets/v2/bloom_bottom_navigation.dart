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
      child: SafeArea(
        top: false,
        child: Row(
          children: const [
            _NavigationItemData(
              index: 0,
              icon: Icons.home_rounded,
              label: 'Dashboard',
            ),
            _NavigationItemData(
              index: 1,
              icon: Icons.insights_rounded,
              label: 'Portfolio',
            ),
            _NavigationItemData(
              index: 2,
              icon: Icons.calculate_rounded,
              label: 'Projection',
            ),
            _NavigationItemData(
              index: 3,
              icon: Icons.person_rounded,
              label: 'Profile',
            ),
          ].map(
            (item) => Expanded(
              child: _NavigationItem(
                data: item,
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}

class _NavigationItemData {
  final int index;
  final IconData icon;
  final String label;

  const _NavigationItemData({
    required this.index,
    required this.icon,
    required this.label,
  });
}

class _NavigationItem extends StatelessWidget {
  final _NavigationItemData data;

  const _NavigationItem({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final navigation =
        context.findAncestorWidgetOfExactType<BloomBottomNavigation>()!;

    final selected = data.index == navigation.currentIndex;

    return InkWell(
      onTap: () => navigation.onTap?.call(data.index),
      child: AnimatedContainer(
        duration: DesignTokens.animationNormal,
        curve: DesignTokens.animationCurve,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: DesignTokens.animationNormal,
              curve: DesignTokens.animationCurve,
              width: 52,
              height: 36,
              decoration: BoxDecoration(
                color: selected
                    ? DesignTokens.primaryLight
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  DesignTokens.radiusMd,
                ),
              ),
              child: Icon(
                data.icon,
                size: 26,
                color: selected
                    ? DesignTokens.primary
                    : DesignTokens.navigationInactive,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: DesignTokens.animationNormal,
              curve: DesignTokens.animationCurve,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w500,
                color: selected
                    ? DesignTokens.primary
                    : DesignTokens.navigationInactive,
              ),
              child: Text(data.label),
            ),
          ],
        ),
      ),
    );
  }
}