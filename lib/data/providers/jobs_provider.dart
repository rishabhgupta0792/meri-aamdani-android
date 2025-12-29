import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job.dart';

class JobsNotifier extends StateNotifier<List<Job>> {
  JobsNotifier() : super([]);

  void addJob(Job job) {
    state = [...state, job];
  }

  void updateJob(String id, Job updatedJob) {
    state = [
      for (final job in state)
        if (job.id == id) updatedJob else job,
    ];
  }

  void deleteJob(String id) {
    state = state.where((job) => job.id != id).toList();
  }

  double get totalEarnings {
    return state.fold(0.0, (sum, job) => sum + job.amount);
  }

  double get pendingEarnings {
    return state
        .where((job) => job.isPending || job.isCompleted)
        .fold(0.0, (sum, job) => sum + job.amount);
  }

  double get collectedEarnings {
    return state
        .where((job) => job.isPaid)
        .fold(0.0, (sum, job) => sum + job.amount);
  }

  List<Job> get thisMonthJobs {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = DateTime(now.year, now.month + 1, 0);
    
    return state.where((job) {
      return job.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
          job.date.isBefore(monthEnd.add(const Duration(days: 1)));
    }).toList();
  }

  double get thisMonthEarnings {
    return thisMonthJobs.fold(0.0, (sum, job) => sum + job.amount);
  }
}

final jobsProvider = StateNotifierProvider<JobsNotifier, List<Job>>((ref) {
  return JobsNotifier();
});

// Convenient computed providers
final totalEarningsProvider = Provider<double>((ref) {
  return ref.watch(jobsProvider.notifier).totalEarnings;
});

final pendingEarningsProvider = Provider<double>((ref) {
  return ref.watch(jobsProvider.notifier).pendingEarnings;
});

final collectedEarningsProvider = Provider<double>((ref) {
  return ref.watch(jobsProvider.notifier).collectedEarnings;
});

final thisMonthEarningsProvider = Provider<double>((ref) {
  return ref.watch(jobsProvider.notifier).thisMonthEarnings;
});
