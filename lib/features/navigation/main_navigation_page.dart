import 'package:flutter/material.dart';

import '../../core/constants/design_tokens.dart';
import '../../models/user_profile.dart';
import '../../shared/widgets/v2/bloom_bottom_navigation.dart';
import '../dashboard/dashboard_page_v2.dart';
import '../projections/projections_page.dart';
import '../simulator/simulator_page.dart';

class MainNavigationPage extends StatefulWidget {
  final UserProfile profile;

  const MainNavigationPage({
    super.key,
    required this.profile,
  });

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  late UserProfile _profile;

  @override
  void initState() {
    super.initState();

    _profile = widget.profile.copyWith();
  }

  @override
  void didUpdateWidget(
    covariant MainNavigationPage oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.profile != widget.profile) {
      _profile = widget.profile.copyWith();
    }
  }

  void _selectPage(int index) {
    if (index < 0 || index > 3 || index == _currentIndex) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _currentIndex = index;
    });
  }

  void _updateProfile(UserProfile updatedProfile) {
    setState(() {
      _profile = updatedProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardPageV2(
            profile: _profile,
          ),
          ProjectionsPage(
            profile: _profile,
            onProfileChanged: _updateProfile,
          ),
          SimulatorPage(
            profile: _profile,
          ),
          const _NavigationPlaceholderPage(
            icon: Icons.person_rounded,
            title: 'Perfil',
            description:
                'Consulta e atualiza os dados do teu plano financeiro.',
          ),
        ],
      ),
      bottomNavigationBar: BloomBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _selectPage,
      ),
    );
  }
}

class _NavigationPlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _NavigationPlaceholderPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(
          DesignTokens.spacingLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BloomHeader(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: DesignTokens.primaryLight,
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusXl,
                          ),
                        ),
                        child: Icon(
                          icon,
                          size: 42,
                          color: DesignTokens.primary,
                        ),
                      ),
                      const SizedBox(
                        height: DesignTokens.spacingLg,
                      ),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          color: DesignTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: DesignTokens.spacingSm,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: DesignTokens.spacingMd,
                      ),
                      const Text(
                        'Disponível numa próxima sprint.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: DesignTokens.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BloomHeader extends StatelessWidget {
  const _BloomHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.eco_outlined,
          size: 30,
          color: DesignTokens.primary,
        ),
        SizedBox(
          width: DesignTokens.spacingSm,
        ),
        Text(
          'Bloom',
          style: TextStyle(
            fontSize: 24,
            height: 1,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: DesignTokens.textPrimary,
          ),
        ),
      ],
    );
  }
}