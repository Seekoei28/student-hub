
class StudyRoom {
  final String id;
  final String name;
  final String description;
  final String module;
  final String createdBy;
  final List<String> members;
  final DateTime createdAt;

  StudyRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.module,
    required this.createdBy,
    required this.members,
    required this.createdAt,
  });

  StudyRoom copyWith({
    String? name,
    String? description,
    String? module,
    List<String>? members,
  }) {
    return StudyRoom(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      module: module ?? this.module,
      createdBy: createdBy,
      members: members ?? this.members,
      createdAt: createdAt,
    );
  }
}
