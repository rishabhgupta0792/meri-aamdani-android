import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/common/widgets/app_button.dart';
import 'package:meri_amdani/data/providers/auth_provider.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';
import '../../main_navigation.dart';

class BankSelectionScreen extends ConsumerStatefulWidget {
  const BankSelectionScreen({super.key});

  @override
  ConsumerState<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends ConsumerState<BankSelectionScreen> {
  final _searchController = TextEditingController();
  String? _selectedBank;
  final List<String> _banks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Punjab National Bank',
    'Bank of Baroda',
    'Canara Bank',
    'Union Bank of India',
    'IndusInd Bank',
    'IDFC First Bank',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_selectedBank != null) {
      ref.read(authProvider.notifier).selectBank(_selectedBank!);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainNavigation()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filteredBanks = _banks
        .where((b) => b.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.select_bank),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.search_bank,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredBanks.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final bank = filteredBanks[index];
                final isSelected = _selectedBank == bank;
                return ListTile(
                  title: Text(bank),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                      : null,
                  onTap: () => setState(() => _selectedBank = bank),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingLg),
            child: AppButton(
              text: l10n.confirm_bank,
              onPressed: _selectedBank != null ? _handleConfirm : null,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
