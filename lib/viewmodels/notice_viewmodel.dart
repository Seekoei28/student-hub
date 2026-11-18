
import 'package:flutter/material.dart';
import '../models/notice.dart';

class NoticeViewModel extends ChangeNotifier {
  final List<Notice> _notices = [
    Notice(
      id: 'notice_001',
      title: 'Examination Timetable Released',
      description:
          'The examination timetable is now available. Please check your examination dates and prepare accordingly.',
      category: 'Examinations',
      priority: 'Important',
      date: DateTime(2026, 11, 12),
    ),
    Notice(
      id: 'notice_002',
      title: 'Assignment Submission Reminder',
      description:
          'Remember to submit your outstanding assignments before the official deadlines.',
      category: 'Academic',
      priority: 'Reminder',
      date: DateTime(2026, 11, 10),
    ),
    Notice(
      id: 'notice_003',
      title: 'Student Registration Information',
      description:
          'Students are reminded to keep their registration information up to date.',
      category: 'General',
      priority: 'General',
      date: DateTime(2026, 11, 8),
    ),
    Notice(
      id: 'notice_004',
      title: 'Library Operating Hours',
      description:
          'Please take note of the library operating hours for the current academic period.',
      category: 'General',
      priority: 'General',
      date: DateTime(2026, 11, 5),
    ),
  ];

  String _selectedCategory = 'All Notices';
  String _searchQuery = '';

  List<Notice> get notices => List.unmodifiable(_notices);

  String get selectedCategory => _selectedCategory;

  int get totalNotices => _notices.length;

  int get unreadCount =>
      _notices.where((notice) => !notice.isRead).length;

  void addNotice({
    required String title,
    required String description,
    required String category,
    required String priority,
  }) {
    final notice = Notice(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      date: DateTime.now(),
    );

    _notices.insert(0, notice);
    notifyListeners();
  }

  void toggleReadStatus(String noticeId) {
    final index = _notices.indexWhere(
      (notice) => notice.id == noticeId,
    );

    if (index == -1) return;

    _notices[index] = _notices[index].copyWith(
      isRead: !_notices[index].isRead,
    );

    notifyListeners();
  }

  void deleteNotice(String noticeId) {
    _notices.removeWhere((notice) => notice.id == noticeId);
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void searchNotices(String query) {
    _searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  List<Notice> get filteredNotices {
    return _notices.where((notice) {
      final matchesCategory =
          _selectedCategory == 'All Notices' ||
          notice.category.toLowerCase() ==
              _selectedCategory.toLowerCase();

      final matchesSearch =
          notice.title.toLowerCase().contains(_searchQuery) ||
          notice.description.toLowerCase().contains(_searchQuery) ||
          notice.category.toLowerCase().contains(_searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();
  }
}
