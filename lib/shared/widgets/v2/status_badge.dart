import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

enum BloomStatus {
  success,
  warning,
  danger,
}

class StatusBadge extends StatelessWidget {
  final BloomStatus status;
  final String label;

  const StatusBadge({
    super.key,
    required this.status,
    required this.label,
  });

  Color get _foregroundColor {
    switch (status) {
      case BloomStatus.success:
        return DesignTokens.success;
      case BloomStatus.warning:
        return DesignTokens.warning;
      case BloomStatus.danger:
        return DesignTokens.danger;
    }
  }

  Color get _backgroundColor {
    switch (status) {
      case BloomStatus.success:
        return DesignTokens.successBackground;
      case BloomStatus.warning:
        return DesignTokens.warningBackground;
      case BloomStatus.danger:
        return DesignTokens.dangerBackground;
    }
  }

  IconData get _icon {
    switch (status) {
      case BloomStatus.success:
        return Icons.check_rounded;
      case BloomStatus.warning:
        return Icons.warning_amber_rounded;
      case BloomStatus.danger:
        return Icons.priority_high_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacingSm,
        vertical: DesignTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusPill,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: _foregroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _icon,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: DesignTokens.spacingXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: _foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}