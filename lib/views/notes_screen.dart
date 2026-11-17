
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/note.dart';
import '../viewmodels/note_viewmodel.dart';
import 'add_edit_note_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAddNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditNoteScreen(),
      ),
    );
  }

  void _openEditNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditNoteScreen(note: note),
      ),
    );
  }

  void _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text(
          'Delete Note?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${note.title}"?',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<NoteViewModel>().deleteNote(note.id);
              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note deleted successfully!'),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getModuleIcon(String module) {
    final value = module.toLowerCase();

    if (value.contains('flutter') || value.contains('programming')) {
      return Icons.phone_android;
    }

    if (value.contains('database') || value.contains('dbm')) {
      return Icons.storage;
    }

    if (value.contains('network') || value.contains('its')) {
      return Icons.wifi;
    }

    if (value.contains('software') || value.contains('sod')) {
      return Icons.code;
    }

    return Icons.description;
  }

  Widget _buildNoteCard(Note note) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getModuleIcon(note.module),
                color: AppColors.lightPurple,
                size: 27,
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  note.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white54,
                ),
                color: AppColors.card,
                onSelected: (value) {
                  if (value == 'edit') {
                    _openEditNote(note);
                  } else if (value == 'delete') {
                    _deleteNote(note);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white70),
                        SizedBox(width: 10),
                        Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.redAccent),
                        SizedBox(width: 10),
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            note.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(
                Icons.book_outlined,
                color: AppColors.lightPurple,
                size: 16,
              ),
              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  note.module,
                  style: const TextStyle(
                    color: AppColors.lightPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),

              Text(
                'Updated ${note.updatedAt.day}/${note.updatedAt.month}/${note.updatedAt.year}',
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            _searchQuery.isEmpty
                ? Icons.note_add_outlined
                : Icons.search_off,
            color: AppColors.lightPurple,
            size: 55,
          ),
          const SizedBox(height: 18),

          Text(
            _searchQuery.isEmpty
                ? 'No Notes Yet'
                : 'No Notes Found',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            _searchQuery.isEmpty
                ? 'Create your first study note to get started.'
                : 'Try searching with a different title or module.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
          ),

          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openAddNote,
              icon: const Icon(Icons.add),
              label: const Text('Create First Note'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewModel>(
      builder: (context, viewModel, child) {
        final filteredNotes =
            viewModel.searchNotes(_searchQuery);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Notes',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Organise your learning and keep important information.',
                style: TextStyle(color: Colors.white60),
              ),

              const SizedBox(height: 25),

              // SEARCH BAR
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search your notes...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightPurple,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.white54,
                          ),
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // NOTES HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Recent Notes',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: _openAddNote,
                    icon: const Icon(Icons.add),
                    label: const Text('New Note'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // NOTES COUNT
              Text(
                '${filteredNotes.length} ${filteredNotes.length == 1 ? 'note' : 'notes'} found',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 16),

              // DYNAMIC NOTE CARDS
              if (filteredNotes.isEmpty)
                _buildEmptyState()
              else
                ...filteredNotes.map(_buildNoteCard),
            ],
          ),
        );
      },
    );
  }
}

