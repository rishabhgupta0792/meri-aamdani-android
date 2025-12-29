import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/common/widgets/app_button.dart';
import 'package:meri_amdani/data/providers/auth_provider.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';
import 'aadhaar_verification_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (phone.length != 10) {
      setState(() {
        _error = AppLocalizations.of(context)!.mobile_placeholder;
      });
      return;
    }

    ref.read(authProvider.notifier).login(phone);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AadhaarVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Card(
            elevation: AppConstants.elevationHigh,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.spacingMd),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.phone_android_rounded,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                  Text(
                    l10n.appSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingXl),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      hintText: l10n.mobile_placeholder,
                      errorText: _error,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                      ),
                    ),
                    onChanged: (val) {
                      if (_error != null) setState(() => _error = null);
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                  AppButton(
                    text: l10n.continueBtn,
                    onPressed: _handleContinue,
                    width: double.infinity,
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
                    child: Text(
                      l10n.terms_text,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
