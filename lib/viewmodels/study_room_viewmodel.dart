
import 'package:flutter/material.dart';
import '../models/study_room.dart';

class StudyRoomViewModel extends ChangeNotifier {
 final List<StudyRoom> _rooms = [
  StudyRoom(
    id: 'room_001',
    name: 'Flutter Development',
    description: 'Learn Flutter and build mobile applications.',
    module: 'Technical Programming',
    createdBy: 'student_002',
    members: ['student_002', 'student_003'],
    createdAt: DateTime.now(),
  ),
  StudyRoom(
    id: 'room_002',
    name: 'Database Management',
    description: 'Explore SQL, databases and data management.',
    module: 'Database Management',
    createdBy: 'student_003',
    members: ['student_003'],
    createdAt: DateTime.now(),
  ),
  StudyRoom(
    id: 'room_003',
    name: 'Software Engineering',
    description: 'Discuss software development and project design.',
    module: 'Software Engineering',
    createdBy: 'student_004',
    members: ['student_004', 'student_005', 'student_006'],
    createdAt: DateTime.now(),
  ),
];

  List<StudyRoom> get rooms => List.unmodifiable(_rooms);

  // Get rooms that a student has joined.
  List<StudyRoom> getJoinedRooms(String studentId) {
    return _rooms
        .where((room) => room.members.contains(studentId))
        .toList();
  }

  // Create a new study room.
  void createRoom({
    required String name,
    required String description,
    required String module,
    required String createdBy,
  }) {
    final now = DateTime.now();

    final room = StudyRoom(
      id: now.microsecondsSinceEpoch.toString(),
      name: name,
      description: description,
      module: module,
      createdBy: createdBy,
      members: [createdBy],
      createdAt: now,
    );

    _rooms.insert(0, room);
    notifyListeners();
  }

  // Join an existing room.
  void joinRoom(String roomId, String studentId) {
    final index = _rooms.indexWhere((room) => room.id == roomId);

    if (index == -1) return;

    final room = _rooms[index];

    if (room.members.contains(studentId)) return;

    _rooms[index] = room.copyWith(
      members: [...room.members, studentId],
    );

    notifyListeners();
  }

  // Leave a study room.
  void leaveRoom(String roomId, String studentId) {
    final index = _rooms.indexWhere((room) => room.id == roomId);

    if (index == -1) return;

    final room = _rooms[index];

    if (!room.members.contains(studentId)) return;

    _rooms[index] = room.copyWith(
      members: room.members
          .where((member) => member != studentId)
          .toList(),
    );

    notifyListeners();
  }

  // Search study rooms by name, description or module.
  List<StudyRoom> searchRooms(String query) {
    final searchQuery = query.toLowerCase().trim();

    if (searchQuery.isEmpty) {
      return rooms;
    }

    return _rooms.where((room) {
      return room.name.toLowerCase().contains(searchQuery) ||
          room.description.toLowerCase().contains(searchQuery) ||
          room.module.toLowerCase().contains(searchQuery);
    }).toList();
  }

  // Delete a room.
  void deleteRoom(String roomId) {
    _rooms.removeWhere((room) => room.id == roomId);
    notifyListeners();
  }
}
