
class Note {
  final String id;
  final String title;
  final String content;
  final String module;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.module,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    String? title,
    String? content,
    String? module,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      module: module ?? this.module,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
