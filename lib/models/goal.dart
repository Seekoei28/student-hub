
class Goal {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime deadline;
  final double progress;
  final DateTime createdAt;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.deadline,
    this.progress = 0.0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isCompleted => progress >= 1.0;

  Goal copyWith({
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    double? progress,
  }) {
    return Goal(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      deadline: deadline ?? this.deadline,
      progress: progress ?? this.progress,
      createdAt: createdAt,
    );
  }
}
