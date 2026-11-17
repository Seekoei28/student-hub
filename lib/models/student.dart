
class Student {
  final String id;
  final String fullName;
  final String email;
  final String studentNumber;
  final String course;
  final int academicYear;

  Student({
    required this.id,
    required this.fullName,
    required this.email,
    required this.studentNumber,
    required this.course,
    required this.academicYear,
  });

  Student copyWith({
    String? id,
    String? fullName,
    String? email,
    String? studentNumber,
    String? course,
    int? academicYear,
  }) {
    return Student(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      studentNumber: studentNumber ?? this.studentNumber,
      course: course ?? this.course,
      academicYear: academicYear ?? this.academicYear,
    );
  }
}
