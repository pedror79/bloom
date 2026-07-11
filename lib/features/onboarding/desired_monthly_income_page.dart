import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/user_profile.dart';
import 'retirement_age_page.dart';

class DesiredMonthlyIncomePage extends StatefulWidget {
  final UserProfile profile;

  const DesiredMonthlyIncomePage({
    super.key,
    required this.profile,
  });

  @override
  State<DesiredMonthlyIncomePage> createState() =>
      _DesiredMonthlyIncomePageState();
}

class _DesiredMonthlyIncomePageState
    extends State<DesiredMonthlyIncomePage> {
  final TextEditingController _incomeController =
      TextEditingController();

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  double? _readIncome() {
    final text = _incomeController.text
        .trim()
        .replaceAll('€', '')
        .replaceAll(' ', '')
        .replaceAll(',', '.');

    return double.tryParse(text);
  }

  void _openRetirementAgePage() {
    final income = _readIncome();

    if (income == null || income <= 0) {
      return;
    }

    widget.profile.desiredMonthlyIncomeToday = income;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RetirementAgePage(
          profile: widget.profile,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final income = _readIncome();
    final isValid = income != null && income > 0;

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
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                    '4/5',
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
                'Quanto gostarias de receber por mês?',
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
                'Indica o rendimento mensal desejado em euros de hoje.',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.4,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _incomeController,
                autofocus: true,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  fontSize: 22,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  prefixText: '€  ',
                  prefixStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                  hintText: 'Ex.: 3 000',
                  hintStyle: const TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) {
                  if (isValid) {
                    _openRetirementAgePage();
                  }
                },
              ),
              const SizedBox(height: 12),
              if (_incomeController.text.isNotEmpty &&
                  !isValid)
                const Text(
                  'Introduz um rendimento mensal superior a zero.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent,
                  ),
                ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed:
                      isValid ? _openRetirementAgePage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppTheme.primary.withValues(
                      alpha: 0.25,
                    ),
                    disabledForegroundColor:
                        Colors.white70,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continuar',
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