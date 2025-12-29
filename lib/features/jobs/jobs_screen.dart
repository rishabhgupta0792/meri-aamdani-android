import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:meri_amdani/core/constants/app_colors.dart';
import 'package:meri_amdani/core/constants/app_constants.dart';
import 'package:meri_amdani/data/models/job.dart';
import 'package:meri_amdani/data/providers/jobs_provider.dart';
import 'package:meri_amdani/common/widgets/app_button.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';

class JobsScreen extends ConsumerStatefulWidget {
  final bool openAddDialog;
  
  const JobsScreen({super.key, this.openAddDialog = false});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openAddDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAddJobDialog();
      });
    }
  }

  void _showAddJobDialog([Job? job]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AddJobSheet(job: job),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final jobs = ref.watch(jobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myJobs),
      ),
      body: jobs.isEmpty
          ? _EmptyState(onAdd: _showAddJobDialog)
          : ListView.separated(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              itemCount: jobs.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppConstants.spacingMd),
              itemBuilder: (context, index) {
                final job = jobs[index];
                return _JobCard(
                  job: job,
                  onTap: () => _showAddJobDialog(job),
                  onDelete: () => ref.read(jobsProvider.notifier).deleteJob(job.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddJobDialog(),
        icon: const Icon(Icons.add),
        label: Text(l10n.addWork),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _JobCard({
    required this.job,
    required this.onTap,
    required this.onDelete,
  });

  Color _getStatusColor() {
    switch (job.status) {
      case JobStatus.pending:
        return AppColors.warning;
      case JobStatus.completed:
        return AppColors.info;
      case JobStatus.paid:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: l10n.rupeeSymbol,
      decimalDigits: 0,
    );
    final dateFormat = DateFormat.yMMMd();

    return Semantics(
      button: true,
      label: '${job.title}, ${job.employerName}, ${currencyFormat.format(job.amount)}',
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppConstants.spacingXs),
                          Row(
                            children: [
                              Icon(
                                Icons.business_rounded,
                                size: AppConstants.iconSm,
                                  color: AppColors.textSecondary
                                      .withValues(alpha: 0.7),
                              ),
                         const SizedBox(width: AppConstants.spacingXs),
                              Text(
                                job.employerName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingMd,
                        vertical: AppConstants.spacingSm,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                      ),
                      child: Text(
                        job.status.displayName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: _getStatusColor(),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: AppConstants.iconSm,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppConstants.spacingXs),
                        Text(
                          dateFormat.format(job.date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Text(
                      currencyFormat.format(job.amount),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline_rounded,
              size: 80,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: AppConstants.spacingLg),
            Text(
              l10n.noJobsYet,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              l10n.addFirstJob,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddJobSheet extends ConsumerStatefulWidget {
  final Job? job;

  const _AddJobSheet({this.job});

  @override
  ConsumerState<_AddJobSheet> createState() => _AddJobSheetState();
}

class _AddJobSheetState extends ConsumerState<_AddJobSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _employerController;
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late DateTime _selectedDate;
  late JobStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.job?.title ?? '');
    _employerController = TextEditingController(text: widget.job?.employerName ?? '');
    _amountController = TextEditingController(
        text: widget.job?.amount.toString() ?? '');
    _notesController = TextEditingController(text: widget.job?.notes ?? '');
    _selectedDate = widget.job?.date ?? DateTime.now();
    _selectedStatus = widget.job?.status ?? JobStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _employerController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveJob() {
    if (_formKey.currentState!.validate()) {
      final job = Job(
        id: widget.job?.id,
        title: _titleController.text,
        employerName: _employerController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        status: _selectedStatus,
        notes: _notesController.text,
      );

      if (widget.job == null) {
        ref.read(jobsProvider.notifier).addJob(job);
      } else {
        ref.read(jobsProvider.notifier).updateJob(job.id, job);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusLg),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.job == null ? l10n.addWork : l10n.edit,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppConstants.spacingLg),
              
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.jobTitle,
                  prefixIcon: const Icon(Icons.work_rounded),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              
              TextFormField(
                controller: _employerController,
                decoration: InputDecoration(
                  labelText: l10n.employerName,
                  prefixIcon: const Icon(Icons.business_rounded),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: l10n.amount,
                  prefixIcon: const Icon(Icons.currency_rupee_rounded),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required';
                  if (double.tryParse(value!) == null) return 'Invalid amount';
                  return null;
                },
              ),
              const SizedBox(height: AppConstants.spacingMd),
              
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: l10n.notes,
                  prefixIcon: const Icon(Icons.note_rounded),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppConstants.spacingLg),
              
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.cancel,
                      type: ButtonType.outlined,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: AppButton(
                      text: l10n.save,
                      onPressed: _saveJob,
                      icon: Icons.check_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
