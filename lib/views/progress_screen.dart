
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../viewmodels/progress_viewmodel.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressViewModel>(
      builder: (context, progress, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Progress',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Track your academic performance and learning goals.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 25),

              // OVERALL PROGRESS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradientStart,
                      AppColors.gradientEnd,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Overall Academic Progress',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${(progress.overallProgress * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress.overallProgress,
                        minHeight: 10,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.lightPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Keep working towards your academic goals!',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // STUDY STATISTICS
              const Text(
                'Study Statistics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _StatCard(
                    title: 'Study Hours',
                    value: '${progress.studyHours} hrs',
                    icon: Icons.access_time,
                  ),
                  _StatCard(
                    title: 'Tasks Completed',
                    value: '${progress.tasksCompleted}',
                    icon: Icons.task_alt,
                  ),
                  _StatCard(
                    title: 'Current Streak',
                    value: '${progress.currentStreak} days',
                    icon: Icons.local_fire_department,
                  ),
                  _StatCard(
                    title: 'Study Sessions',
                    value: '${progress.studySessions}',
                    icon: Icons.menu_book,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // PROGRESS ACTIONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        progress.addStudyHours(1);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Study Hour'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        progress.recordStudySession();
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Log Session'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // MODULE PROGRESS
              const Text(
                'Module Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              _ModuleProgressCard(
                module: 'Technical Programming III',
                code: 'TPG316C',
                progress: progress.moduleProgress['TPG316C'] ?? 0,
                onChanged: (value) {
                  progress.updateModuleProgress('TPG316C', value);
                },
              ),
              _ModuleProgressCard(
                module: 'Software Engineering',
                code: 'SOD316C',
                progress: progress.moduleProgress['SOD316C'] ?? 0,
                onChanged: (value) {
                  progress.updateModuleProgress('SOD316C', value);
                },
              ),
              _ModuleProgressCard(
                module: 'Communication Networks',
                code: 'CMN316C',
                progress: progress.moduleProgress['CMN316C'] ?? 0,
                onChanged: (value) {
                  progress.updateModuleProgress('CMN316C', value);
                },
              ),
              _ModuleProgressCard(
                module: 'Information Technology',
                code: 'ITS316C',
                progress: progress.moduleProgress['ITS316C'] ?? 0,
                onChanged: (value) {
                  progress.updateModuleProgress('ITS316C', value);
                },
              ),

              const SizedBox(height: 30),

              // COMPLETED TASKS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recently Completed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddTaskDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Task'),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              if (progress.completedTasks.isEmpty)
                const Text(
                  'No completed tasks yet.',
                  style: TextStyle(color: Colors.white60),
                )
              else
                ...progress.completedTasks.map(
                  (task) => _buildCompletedTask(
                    context,
                    task,
                    progress,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final controller = TextEditingController();

    final task = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Add Completed Task',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, controller.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (task != null && context.mounted) {
      context.read<ProgressViewModel>().addCompletedTask(task);
    }
  }

  Widget _buildCompletedTask(
    BuildContext context,
    String title,
    ProgressViewModel progress,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.lightPurple,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            tooltip: 'Remove task',
            onPressed: () {
              progress.removeCompletedTask(title);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.lightPurple,
            size: 27,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleProgressCard extends StatelessWidget {
  final String module;
  final String code;
  final double progress;
  final ValueChanged<double> onChanged;

  const _ModuleProgressCard({
    required this.module,
    required this.code,
    required this.progress,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  module,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.lightPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Slider(
            value: progress.clamp(0.0, 1.0),
            min: 0,
            max: 1,
            activeColor: AppColors.primary,
            inactiveColor: Colors.white12,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

