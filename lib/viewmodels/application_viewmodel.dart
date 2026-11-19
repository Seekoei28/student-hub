
import 'package:flutter/material.dart';
import '../models/application.dart';

class ApplicationViewModel extends ChangeNotifier {
  // AVAILABLE STUDENT ASSISTANT OPPORTUNITIES
  final List<AssistantOpportunity> _opportunities = [
    const AssistantOpportunity(
      id: 'opp_001',
      title: 'Flutter Development Assistant',
      module: 'Technical Programming III',
      moduleCode: 'TPG316C',
      academicLevel: 'Third Year',
      description:
          'Assist students with Flutter development practicals and programming concepts.',
      requirements: [
        'Must be a third-year student',
        'Must have passed Technical Programming II',
        'Good understanding of Flutter and Dart',
      ],
    ),
    const AssistantOpportunity(
      id: 'opp_002',
      title: 'Database Assistant',
      module: 'Database Management',
      moduleCode: 'DBM316C',
      academicLevel: 'Second Year',
      description:
          'Help students understand database design, SQL queries and database concepts.',
      requirements: [
        'Must be a second-year student',
        'Must have passed introductory database modules',
        'Good understanding of SQL',
      ],
    ),
    const AssistantOpportunity(
      id: 'opp_003',
      title: 'Networking Assistant',
      module: 'Communication Networks',
      moduleCode: 'CMN316C',
      academicLevel: 'Third Year',
      description:
          'Assist students with networking practicals, configurations and troubleshooting.',
      requirements: [
        'Must be a third-year student',
        'Must have networking fundamentals',
        'Knowledge of Cisco Packet Tracer',
      ],
    ),
  ];

  // STUDENT APPLICATIONS
  final List<StudentApplication> _applications = [];

  // GETTERS
  List<AssistantOpportunity> get opportunities =>
      List.unmodifiable(_opportunities);

  List<StudentApplication> get applications =>
      List.unmodifiable(_applications);

  int get totalApplications => _applications.length;

  int get pendingApplications =>
      _applications.where((app) => app.status == 'Pending').length;

  int get approvedApplications =>
      _applications.where((app) => app.status == 'Approved').length;

  int get rejectedApplications =>
      _applications.where((app) => app.status == 'Rejected').length;

  // CHECK WHETHER A STUDENT HAS ALREADY APPLIED
  bool hasApplied(String opportunityId) {
    return _applications.any(
      (app) => app.opportunityId == opportunityId,
    );
  }

  // SUBMIT AN APPLICATION
  bool applyForOpportunity(String opportunityId) {
    if (hasApplied(opportunityId)) {
      return false;
    }

    final opportunity = _opportunities.firstWhere(
      (item) => item.id == opportunityId,
    );

    final application = StudentApplication(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      opportunityId: opportunity.id,
      title: opportunity.title,
      module: opportunity.module,
      moduleCode: opportunity.moduleCode,
      academicLevel: opportunity.academicLevel,
      status: 'Pending',
      appliedAt: DateTime.now(),
    );

    _applications.insert(0, application);

    notifyListeners();
    return true;
  }

  // UPDATE APPLICATION STATUS
  void updateApplicationStatus(String applicationId, String newStatus) {
    final index = _applications.indexWhere(
      (app) => app.id == applicationId,
    );

    if (index == -1) return;

    _applications[index] = _applications[index].copyWith(
      status: newStatus,
    );

    notifyListeners();
  }

  // DELETE AN APPLICATION
  void deleteApplication(String applicationId) {
    _applications.removeWhere(
      (app) => app.id == applicationId,
    );

    notifyListeners();
  }
}
