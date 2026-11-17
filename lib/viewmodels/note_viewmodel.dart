
import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteViewModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote({
    required String title,
    required String content,
    required String module,
  }) {
    final now = DateTime.now();

    final note = Note(
      id: now.microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      module: module,
      createdAt: now,
      updatedAt: now,
    );

    _notes.insert(0, note);
    notifyListeners();
  }

  void updateNote({
    required String id,
    required String title,
    required String content,
    required String module,
  }) {
    final index = _notes.indexWhere((note) => note.id == id);

    if (index == -1) return;

    _notes[index] = _notes[index].copyWith(
      title: title,
      content: content,
      module: module,
      updatedAt: DateTime.now(),
    );

    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  List<Note> searchNotes(String query) {
    final searchQuery = query.toLowerCase().trim();

    if (searchQuery.isEmpty) {
      return notes;
    }

    return _notes.where((note) {
      return note.title.toLowerCase().contains(searchQuery) ||
          note.content.toLowerCase().contains(searchQuery) ||
          note.module.toLowerCase().contains(searchQuery);
    }).toList();
  }
}
