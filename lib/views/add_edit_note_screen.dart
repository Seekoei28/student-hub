
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/note.dart';
import '../viewmodels/note_viewmodel.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({super.key, this.note});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _moduleController;

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.note?.title ?? '');

    _contentController =
        TextEditingController(text: widget.note?.content ?? '');

    _moduleController =
        TextEditingController(text: widget.note?.module ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _moduleController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (!_formKey.currentState!.validate()) return;

    final viewModel = context.read<NoteViewModel>();

    if (isEditing) {
      viewModel.updateNote(
        id: widget.note!.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        module: _moduleController.text.trim(),
      );
    } else {
      viewModel.addNote(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        module: _moduleController.text.trim(),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isEditing
              ? 'Note updated successfully!'
              : 'Note created successfully!',
        ),
      ),
    );

    Navigator.pop(context);
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.white60),
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: AppColors.card,
          alignLabelWithHint: maxLines > 1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Update your study note' : 'Create a new study note',
                style: const TextStyle(
                  color: AppColors.lightPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              _buildField(
                label: 'Note Title',
                controller: _titleController,
                hint: 'e.g. Introduction to Flutter',
              ),

              _buildField(
                label: 'Module',
                controller: _moduleController,
                hint: 'e.g. TPG316C',
              ),

              _buildField(
                label: 'Note Content',
                controller: _contentController,
                hint: 'Write your study notes here...',
                maxLines: 10,
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveNote,
                  icon: Icon(
                    isEditing ? Icons.update : Icons.save,
                  ),
                  label: Text(
                    isEditing ? 'Update Note' : 'Save Note',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
