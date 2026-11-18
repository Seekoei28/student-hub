
class Event {
  final String id;
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final String time;
  final String venue;
  final String createdBy;
  final List<String> attendees;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.time,
    required this.venue,
    required this.createdBy,
    required this.attendees,
  });

  Event copyWith({
    String? title,
    String? category,
    String? description,
    DateTime? date,
    String? time,
    String? venue,
    List<String>? attendees,
  }) {
    return Event(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      venue: venue ?? this.venue,
      createdBy: createdBy,
      attendees: attendees ?? this.attendees,
    );
  }
}
