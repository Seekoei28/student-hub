
import 'package:flutter/material.dart';
import '../models/event.dart';

class EventViewModel extends ChangeNotifier {
  final String _studentId = 'student_001';

  final List<Event> _events = [
    Event(
      id: 'event_001',
      title: 'Technology Innovation Workshop',
      category: 'Workshops',
      description:
          'Explore new technologies, innovation and practical IT skills.',
      date: DateTime(2026, 11, 18),
      time: '10:00 AM',
      venue: 'Computer Laboratory',
      createdBy: 'admin',
      attendees: [],
    ),
    Event(
      id: 'event_002',
      title: 'Student Networking Day',
      category: 'Social',
      description:
          'Connect with fellow students and build meaningful relationships.',
      date: DateTime(2026, 11, 21),
      time: '12:00 PM',
      venue: 'Student Centre',
      createdBy: 'admin',
      attendees: [],
    ),
    Event(
      id: 'event_003',
      title: 'Academic Career Seminar',
      category: 'Academic',
      description:
          'Discover career opportunities and get academic guidance.',
      date: DateTime(2026, 11, 25),
      time: '09:00 AM',
      venue: 'Main Auditorium',
      createdBy: 'admin',
      attendees: [],
    ),
    Event(
      id: 'event_004',
      title: 'Campus Sports Day',
      category: 'Sports',
      description:
          'Enjoy a day of sporting activities and friendly competition.',
      date: DateTime(2026, 11, 28),
      time: '08:00 AM',
      venue: 'Sports Grounds',
      createdBy: 'admin',
      attendees: [],
    ),
  ];

  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<Event> get events => List.unmodifiable(_events);

  String get selectedCategory => _selectedCategory;

  List<Event> get registeredEvents {
    return _events
        .where((event) => event.attendees.contains(_studentId))
        .toList();
  }

  int get totalEvents => _events.length;

  int get registeredCount => registeredEvents.length;

  void registerForEvent(String eventId) {
    final index = _events.indexWhere((event) => event.id == eventId);

    if (index == -1) return;

    final event = _events[index];

    if (event.attendees.contains(_studentId)) return;

    _events[index] = event.copyWith(
      attendees: [...event.attendees, _studentId],
    );

    notifyListeners();
  }

  void cancelRegistration(String eventId) {
    final index = _events.indexWhere((event) => event.id == eventId);

    if (index == -1) return;

    final event = _events[index];

    _events[index] = event.copyWith(
      attendees: event.attendees
          .where((studentId) => studentId != _studentId)
          .toList(),
    );

    notifyListeners();
  }

  bool isRegistered(String eventId) {
    final event = _events.firstWhere(
      (event) => event.id == eventId,
    );

    return event.attendees.contains(_studentId);
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void searchEvents(String query) {
    _searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  List<Event> get filteredEvents {
    return _events.where((event) {
      final matchesCategory = _selectedCategory == 'All' ||
          event.category.toLowerCase() ==
              _selectedCategory.toLowerCase();

      final matchesSearch =
          event.title.toLowerCase().contains(_searchQuery) ||
          event.category.toLowerCase().contains(_searchQuery) ||
          event.description.toLowerCase().contains(_searchQuery) ||
          event.venue.toLowerCase().contains(_searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();
  }
}
