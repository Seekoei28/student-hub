
import 'package:flutter/material.dart';
import '../models/goal.dart';

class GoalViewModel extends ChangeNotifier {
  final List<Goal> _goals = [
    Goal(
      id: 'goal_001',
      title: 'Complete Flutter Project',
      description: 'Finish all StudentHub application features.',
      category: 'Academic',
      deadline: DateTime.now().add(const Duration(days: 14)),
      progress: 0.65,
    ),
    Goal(
      id: 'goal_002',
      title: 'Improve Programming Skills',
      description: 'Practice Dart and Flutter development.',
      category: 'Personal',
      deadline: DateTime.now().add(const Duration(days: 30)),
      progress: 0.30,
    ),
    Goal(
      id: 'goal_003',
      title: 'Prepare for Examinations',
      description: 'Revise all semester modules.',
      category: 'Academic',
      deadline: DateTime.now().add(const Duration(days: 21)),
      progress: 0.0,
    ),
  ];

  List<Goal> get goals => List.unmodifiable(_goals);

  List<Goal> get activeGoals =>
      _goals.where((goal) => !goal.isCompleted).toList();

  List<Goal> get completedGoals =>
      _goals.where((goal) => goal.isCompleted).toList();

  int get totalGoals => _goals.length;

  int get completedCount => completedGoals.length;

  int get activeCount => activeGoals.length;

  void addGoal({
    required String title,
    required String description,
    required String category,
    required DateTime deadline,
  }) {
    final goal = Goal(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      deadline: deadline,
    );

    _goals.add(goal);
    notifyListeners();
  }

  void updateGoal(Goal updatedGoal) {
    final index = _goals.indexWhere(
      (goal) => goal.id == updatedGoal.id,
    );

    if (index == -1) return;

    _goals[index] = updatedGoal;
    notifyListeners();
  }

  void updateProgress(String id, double progress) {
    final index = _goals.indexWhere(
      (goal) => goal.id == id,
    );

    if (index == -1) return;

    _goals[index] = _goals[index].copyWith(
      progress: progress.clamp(0.0, 1.0),
    );

    notifyListeners();
  }

  void deleteGoal(String id) {
    _goals.removeWhere((goal) => goal.id == id);
    notifyListeners();
  }

  void markAsCompleted(String id) {
    updateProgress(id, 1.0);
  }
}
