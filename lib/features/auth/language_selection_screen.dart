import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/data/providers/auth_provider.dart';
import 'login_screen.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.language_rounded,
                size: 80,
                color: AppColors.primary,
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Text(
                'Select Language / भाषा चुनें',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                'Choose your preferred language to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingXl),
              _LanguageButton(
                title: 'English',
                subtitle: 'English',
                onTap: () => _handleSelect(ref, context, 'en'),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _LanguageButton(
                title: 'हिंदी',
                subtitle: 'Hindi',
                onTap: () => _handleSelect(ref, context, 'hi'),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _LanguageButton(
                title: 'मराठी',
                subtitle: 'Marathi',
                onTap: () => _handleSelect(ref, context, 'mr'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSelect(WidgetRef ref, BuildContext context, String lang) {
    ref.read(authProvider.notifier).setLanguage(lang);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LanguageButton({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingMd,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
