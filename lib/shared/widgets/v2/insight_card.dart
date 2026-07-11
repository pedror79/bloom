import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onTap;

  const InsightCard({
    super.key,
    required this.title,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          DesignTokens.radiusLg,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: DesignTokens.primaryLight,
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusLg,
            ),
            border: Border.all(
              color: DesignTokens.borderSoft,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              DesignTokens.spacingLg,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: DesignTokens.iconContainerMedium,
                  height: DesignTokens.iconContainerMedium,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMd,
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: DesignTokens.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: DesignTokens.primaryDark,
                        ),
                      ),
                      const SizedBox(
                        height: DesignTokens.spacingSm,
                      ),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.45,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: DesignTokens.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}