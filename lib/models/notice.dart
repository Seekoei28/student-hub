
class Notice {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority;
  final DateTime date;
  final bool isRead;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.date,
    this.isRead = false,
  });

  Notice copyWith({
    String? title,
    String? description,
    String? category,
    String? priority,
    DateTime? date,
    bool? isRead,
  }) {
    return Notice(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }
}
