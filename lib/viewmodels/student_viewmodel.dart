
import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentViewModel extends ChangeNotifier {
  Student? _student;

  // Get the current student
  Student? get student => _student;

  // Check whether a student is available
  bool get hasStudent => _student != null;

  // Add or set student information
  void setStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  // Update existing student information
  void updateStudent({
    String? fullName,
    String? email,
    String? studentNumber,
    String? course,
    int? academicYear,
  }) {
    if (_student == null) return;

    _student = _student!.copyWith(
      fullName: fullName,
      email: email,
      studentNumber: studentNumber,
      course: course,
      academicYear: academicYear,
    );

    notifyListeners();
  }

  // Clear student information
  void clearStudent() {
    _student = null;
    notifyListeners();
  }
}
