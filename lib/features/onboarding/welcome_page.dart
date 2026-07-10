import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'name_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.eco_outlined,
                  size: 38,
                  color: AppTheme.primary,
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Bem-vindo à Bloom',
                style: TextStyle(
                  fontSize: 42,
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.2,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Descobre quando podes viver a vida que desejas.',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.35,
                  color: AppTheme.textSecondary,
                ),
              ),

              const Spacer(),

              const Row(
                children: [
                  Icon(
                    Icons.schedule_outlined,
                    size: 20,
                    color: AppTheme.textSecondary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Demora menos de 2 minutos',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NamePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Começar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}