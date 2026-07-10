import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user_profile.dart';
import '../dashboard/dashboard_page.dart';

class RetirementAgePage extends StatefulWidget {
  final UserProfile profile;

  const RetirementAgePage({
    super.key,
    required this.profile,
  });

  @override
  State<RetirementAgePage> createState() => _RetirementAgePageState();
}

class _RetirementAgePageState extends State<RetirementAgePage> {
  final TextEditingController _retirementAgeController =
      TextEditingController();

  @override
  void dispose() {
    _retirementAgeController.dispose();
    super.dispose();
  }

  int? _readRetirementAge() {
    return int.tryParse(_retirementAgeController.text.trim());
  }

  void _openDashboard() {
    final retirementAge = _readRetirementAge();
    final currentAge = widget.profile.age;

    if (retirementAge == null || currentAge == null) {
      return;
    }

    if (retirementAge <= currentAge || retirementAge > 100) {
      return;
    }

    widget.profile.retirementAge = retirementAge;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage(
          profile: widget.profile,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final retirementAge = _readRetirementAge();
    final currentAge = widget.profile.age;

    final isValid = retirementAge != null &&
        currentAge != null &&
        retirementAge > currentAge &&
        retirementAge <= 100;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const Text(
                    '4/4',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              const Text(
                'Com que idade gostarias de atingir a liberdade financeira?',
                style: TextStyle(
                  fontSize: 40,
                  height: 1.08,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Este será o objetivo principal do teu plano.',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.4,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _retirementAgeController,
                autofocus: true,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 22,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Ex.: 58',
                  hintStyle: const TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                  suffixText: 'anos',
                  suffixStyle: const TextStyle(
                    fontSize: 18,
                    color: AppTheme.textSecondary,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) {
                  if (isValid) {
                    _openDashboard();
                  }
                },
              ),
              const SizedBox(height: 12),
              if (_retirementAgeController.text.isNotEmpty && !isValid)
                Text(
                  currentAge == null
                      ? 'Não foi possível identificar a tua idade atual.'
                      : 'Escolhe uma idade superior a $currentAge.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: isValid ? _openDashboard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppTheme.primary.withValues(alpha: 0.25),
                    disabledForegroundColor: Colors.white70,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ver o meu plano',
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