import 'package:uuid/uuid.dart';

enum JobStatus {
  pending,
  completed,
  paid;

  String get displayName {
    switch (this) {
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.paid:
        return 'Paid';
    }
  }
}

class Job {
  final String id;
  final String title;
  final String employerName;
  final double amount;
  final DateTime date;
  final JobStatus status;
  final String notes;
  final DateTime createdAt;

  Job({
    String? id,
    required this.title,
    required this.employerName,
    required this.amount,
    required this.date,
    this.status = JobStatus.pending,
    this.notes = '',
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Job copyWith({
    String? title,
    String? employerName,
    double? amount,
    DateTime? date,
    JobStatus? status,
    String? notes,
  }) {
    return Job(
      id: id,
      title: title ?? this.title,
      employerName: employerName ?? this.employerName,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'employerName': employerName,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      title: json['title'] as String,
      employerName: json['employerName'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      status: JobStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => JobStatus.pending,
      ),
      notes: json['notes'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  bool get isPending => status == JobStatus.pending;
  bool get isCompleted => status == JobStatus.completed;
  bool get isPaid => status == JobStatus.paid;
}
