
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/student.dart';
import '../viewmodels/student_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _studentNumberController;
  late TextEditingController _courseController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();

    final student = context.read<StudentViewModel>().student;

    _nameController =
        TextEditingController(text: student?.fullName ?? '');

    _emailController =
        TextEditingController(text: student?.email ?? '');

    _studentNumberController =
        TextEditingController(text: student?.studentNumber ?? '');

    _courseController =
        TextEditingController(text: student?.course ?? '');

    _yearController = TextEditingController(
      text: student != null ? student.academicYear.toString() : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _studentNumberController.dispose();
    _courseController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final viewModel = context.read<StudentViewModel>();
    final existingStudent = viewModel.student;

    final student = Student(
      id: existingStudent?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      studentNumber: _studentNumberController.text.trim(),
      course: _courseController.text.trim(),
      academicYear: int.parse(_yearController.text.trim()),
    );

    viewModel.setStudent(student);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student profile saved successfully!'),
      ),
    );

    Navigator.pop(context);
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white60),
          filled: true,
          fillColor: AppColors.card,
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
            return 'Please enter your $label';
          }

          if (label == 'Email' &&
              !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                  .hasMatch(value.trim())) {
            return 'Enter a valid email address';
          }

          if (label == 'Academic Year') {
            final year = int.tryParse(value.trim());

            if (year == null || year < 1 || year > 10) {
              return 'Enter a valid academic year';
            }
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
        title: const Text('Edit Student Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  color: AppColors.lightPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              _buildField('Full Name', _nameController),

              _buildField(
                'Email',
                _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              _buildField(
                'Student Number',
                _studentNumberController,
              ),

              _buildField('Course', _courseController),

              _buildField(
                'Academic Year',
                _yearController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
