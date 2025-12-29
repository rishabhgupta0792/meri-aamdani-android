import 'package:flutter/material.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    'Gig Worker',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          
          _ProfileOption(
            icon: Icons.language_rounded,
            title: l10n.language,
            subtitle: 'English / हिंदी',
            onTap: () {
              // Language selection dialog would go here
            },
          ),
          
          _ProfileOption(
            icon: Icons.settings_rounded,
            title: l10n.settings,
            onTap: () {},
          ),
          
          _ProfileOption(
            icon: Icons.info_rounded,
            title: l10n.about,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: AppConstants.iconLg),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
        minVerticalPadding: AppConstants.spacingMd,
      ),
    );
  }
}
