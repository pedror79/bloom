import 'package:flutter/material.dart';

import '../../../core/constants/design_tokens.dart';

class PageIntroduction extends StatelessWidget {
  const PageIntroduction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projeções',
          style: TextStyle(
            fontSize: 34,
            height: 1.08,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.9,
            color: DesignTokens.textPrimary,
          ),
        ),
        SizedBox(
          height: DesignTokens.spacingXs,
        ),
        Text(
          'Experimenta diferentes cenários e acompanha o impacto no teu plano.',
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            fontWeight: FontWeight.w500,
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }
}