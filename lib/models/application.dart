
class AssistantOpportunity {
  final String id;
  final String title;
  final String module;
  final String moduleCode;
  final String academicLevel;
  final String description;
  final List<String> requirements;

  const AssistantOpportunity({
    required this.id,
    required this.title,
    required this.module,
    required this.moduleCode,
    required this.academicLevel,
    required this.description,
    required this.requirements,
  });
}

class StudentApplication {
  final String id;
  final String opportunityId;
  final String title;
  final String module;
  final String moduleCode;
  final String academicLevel;
  final String status;
  final DateTime appliedAt;

  const StudentApplication({
    required this.id,
    required this.opportunityId,
    required this.title,
    required this.module,
    required this.moduleCode,
    required this.academicLevel,
    required this.status,
    required this.appliedAt,
  });

  StudentApplication copyWith({
    String? status,
  }) {
    return StudentApplication(
      id: id,
      opportunityId: opportunityId,
      title: title,
      module: module,
      moduleCode: moduleCode,
      academicLevel: academicLevel,
      status: status ?? this.status,
      appliedAt: appliedAt,
    );
  }
}
