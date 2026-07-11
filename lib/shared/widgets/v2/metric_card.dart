import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final IconData icon;
  final String actionLabel;
  final VoidCallback? onTap;
  final Widget? supportingContent;

  const MetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.actionLabel,
    this.onTap,
    this.supportingContent,
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
            color: DesignTokens.surface,
            borderRadius: BorderRadius.circular(
              DesignTokens.radiusLg,
            ),
            border: Border.all(
              color: DesignTokens.borderSoft,
            ),
            boxShadow: DesignTokens.cardShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              DesignTokens.spacingLg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.25,
                          fontWeight: FontWeight.w700,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: DesignTokens.spacingSm,
                    ),
                    Container(
                      width:
                          DesignTokens.iconContainerMedium,
                      height:
                          DesignTokens.iconContainerMedium,
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryLight,
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusMd,
                        ),
                      ),
                      child: Icon(
                        icon,
                        size: 25,
                        color: DesignTokens.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: DesignTokens.spacingXs,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    color: DesignTokens.textSecondary,
                  ),
                ),
                const SizedBox(
                  height: DesignTokens.spacingMd,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 27,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: DesignTokens.textPrimary,
                  ),
                ),
                if (supportingContent != null) ...[
                  const SizedBox(
                    height: DesignTokens.spacingSm,
                  ),
                  supportingContent!,
                ],
                const Spacer(),
                const SizedBox(
                  height: DesignTokens.spacingSm,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        actionLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: DesignTokens.primary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 22,
                      color: DesignTokens.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}