import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/data/providers/jobs_provider.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';

class EarningsCard extends ConsumerWidget {
  const EarningsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final thisMonthEarnings = ref.watch(thisMonthEarningsProvider);
    final pendingEarnings = ref.watch(pendingEarningsProvider);
    final collectedEarnings = ref.watch(collectedEarningsProvider);
    
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: l10n.rupeeSymbol,
      decimalDigits: 0,
    );

    return Semantics(
      label: '${l10n.totalEarnings} ${l10n.thisMonth}',
      value: currencyFormat.format(thisMonthEarnings),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          boxShadow: [
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Earnings Label
            Text(
              l10n.totalEarnings,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.9),
                  ),
            ),
            Text(
              l10n.thisMonth,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.8),
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSm),
            
            // Amount - Large and prominent
            Text(
              currencyFormat.format(thisMonthEarnings),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            const SizedBox(height: AppConstants.spacingLg),
            const Divider(color: Colors.white24),
            const SizedBox(height: AppConstants.spacingMd),
            
            // Pending and Collected
            Row(
              children: [
                Expanded(
                  child: _EarningsSegment(
                    label: l10n.pendingIncome,
                    amount: currencyFormat.format(pendingEarnings),
                    icon: Icons.access_time_rounded,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),
                Expanded(
                  child: _EarningsSegment(
                    label: l10n.collectedIncome,
                    amount: currencyFormat.format(collectedEarnings),
                    icon: Icons.check_circle_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EarningsSegment extends StatelessWidget {
  final String label;
  final String amount;
  final IconData icon;

  const _EarningsSegment({
    required this.label,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      value: amount,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppConstants.iconSm,
                color: AppColors.onPrimary.withValues(alpha: 0.9),
              ),
              const SizedBox(width: AppConstants.spacingXs),
              Flexible(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.9),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingXs),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
