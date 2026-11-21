
import 'package:flutter/material.dart';

class ProgressViewModel extends ChangeNotifier {
  double _overallProgress = 0.75;
  int _studyHours = 24;
  int _tasksCompleted = 18;
  int _currentStreak = 5;
  int _studySessions = 32;

  final Map<String, double> _moduleProgress = {
    'TPG316C': 0.85,
    'SOD316C': 0.70,
    'CMN316C': 0.65,
    'ITS316C': 0.90,
  };

  final List<String> _completedTasks = [
    'Flutter UI Assignment',
    'Database Practical',
    'Networking Exercises',
  ];

  double get overallProgress => _overallProgress;
  int get studyHours => _studyHours;
  int get tasksCompleted => _tasksCompleted;
  int get currentStreak => _currentStreak;
  int get studySessions => _studySessions;

  Map<String, double> get moduleProgress =>
      Map.unmodifiable(_moduleProgress);

  List<String> get completedTasks =>
      List.unmodifiable(_completedTasks);

  void updateOverallProgress(double progress) {
    _overallProgress = progress.clamp(0.0, 1.0);
    notifyListeners();
  }

  void updateModuleProgress(String code, double progress) {
    if (!_moduleProgress.containsKey(code)) return;

    _moduleProgress[code] = progress.clamp(0.0, 1.0);
    notifyListeners();
  }

  void addStudyHours(int hours) {
    if (hours <= 0) return;

    _studyHours += hours;
    notifyListeners();
  }

  void recordStudySession() {
    _studySessions++;
    notifyListeners();
  }

  void addCompletedTask(String task) {
    final trimmedTask = task.trim();

    if (trimmedTask.isEmpty ||
        _completedTasks.contains(trimmedTask)) {
      return;
    }

    _completedTasks.add(trimmedTask);
    _tasksCompleted++;
    notifyListeners();
  }

  void removeCompletedTask(String task) {
    if (_completedTasks.remove(task)) {
      if (_tasksCompleted > 0) {
        _tasksCompleted--;
      }
      notifyListeners();
    }
  }

  void updateStreak(int days) {
    if (days < 0) return;

    _currentStreak = days;
    notifyListeners();
  }
}
