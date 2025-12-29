import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/common/widgets/app_button.dart';
import 'package:meri_amdani/data/providers/auth_provider.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';
import 'bank_selection_screen.dart';

class AadhaarVerificationScreen extends ConsumerStatefulWidget {
  const AadhaarVerificationScreen({super.key});

  @override
  ConsumerState<AadhaarVerificationScreen> createState() => _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends ConsumerState<AadhaarVerificationScreen> {
  int _step = 1; // 1: Aadhaar Input, 2: OTP Input
  final _aadhaarController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _aadhaarController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _handleSendOTP() {
    final aadhaar = _aadhaarController.text.replaceAll(RegExp(r'\D'), '');
    if (aadhaar.length != 12) {
      setState(() => _error = 'Please enter valid 12-digit Aadhaar');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Mock API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _step = 2;
        });
      }
    });
  }

  void _handleVerify() {
    final otp = _otpController.text.replaceAll(RegExp(r'\D'), '');
    if (otp.length != 6) {
      setState(() => _error = 'Please enter valid 6-digit OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Mock verification
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        ref.read(authProvider.notifier).verifyAadhaar();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BankSelectionScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.identity_verification),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Column(
          children: [
            const Icon(
              Icons.verified_user_rounded,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              _step == 1 ? l10n.enter_aadhaar_desc : l10n.enter_otp_desc,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingXl),
            if (_step == 1) ...[
              TextField(
                controller: _aadhaarController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 4),
                decoration: InputDecoration(
                  hintText: l10n.aadhaar_placeholder,
                  errorText: _error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              AppButton(
                text: l10n.send_otp,
                onPressed: _handleSendOTP,
                isLoading: _isLoading,
                width: double.infinity,
                icon: Icons.arrow_forward_rounded,
              ),
            ] else ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
                decoration: InputDecoration(
                  hintText: l10n.enter_otp_placeholder,
                  errorText: _error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingLg),
              AppButton(
                text: l10n.verify_proceed,
                onPressed: _handleVerify,
                isLoading: _isLoading,
                width: double.infinity,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              TextButton(
                onPressed: () => setState(() => _step = 1),
                child: Text(l10n.back_aadhaar),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
