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
    const List<_NavigationItemData> items = [
      _NavigationItemData(
        index: 0,
        icon: Icons.home_rounded,
        label: 'Dashboard',
      ),
      _NavigationItemData(
        index: 1,
        icon: Icons.insights_rounded,
        label: 'Projeções',
      ),
      _NavigationItemData(
        index: 2,
        icon: Icons.calculate_rounded,
        label: 'Simulador',
      ),
      _NavigationItemData(
        index: 3,
        icon: Icons.compare_arrows_rounded,
        label: 'Comparar',
      ),
      _NavigationItemData(
        index: 4,
        icon: Icons.person_rounded,
        label: 'Perfil',
      ),
    ];

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
          children: items.map(
            (item) {
              return Expanded(
                child: _NavigationItem(
                  data: item,
                  selected: item.index == currentIndex,
                  onTap: onTap,
                ),
              );
            },
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
  final bool selected;
  final ValueChanged<int>? onTap;

  const _NavigationItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              onTap!(data.index);
            },
      child: AnimatedContainer(
        duration: DesignTokens.animationNormal,
        curve: DesignTokens.animationCurve,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: DesignTokens.animationNormal,
              curve: DesignTokens.animationCurve,
              width: 46,
              height: 34,
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
                size: 24,
                color: selected
                    ? DesignTokens.primary
                    : DesignTokens.navigationInactive,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            AnimatedDefaultTextStyle(
              duration: DesignTokens.animationNormal,
              curve: DesignTokens.animationCurve,
              style: TextStyle(
                fontSize: 10,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: selected
                    ? DesignTokens.primary
                    : DesignTokens.navigationInactive,
              ),
              child: Text(
                data.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}