
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/goal.dart';
import '../viewmodels/goal_viewmodel.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Consumer<GoalViewModel>(
      builder: (context, viewModel, child) {
        final goals = viewModel.goals.where((goal) {
          if (_selectedFilter == 'Active') {
            return !goal.isCompleted;
          }
          if (_selectedFilter == 'Completed') {
            return goal.isCompleted;
          }
          return true;
        }).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Goals',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Set targets, track progress and achieve your ambitions.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 24),

              // SUMMARY CARDS
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _SummaryCard(
                    title: 'Total Goals',
                    value: '${viewModel.totalGoals}',
                    icon: Icons.flag,
                  ),
                  _SummaryCard(
                    title: 'Active Goals',
                    value: '${viewModel.activeCount}',
                    icon: Icons.track_changes,
                  ),
                  _SummaryCard(
                    title: 'Completed',
                    value: '${viewModel.completedCount}',
                    icon: Icons.check_circle,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // CREATE GOAL BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showGoalDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Create New Goal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // FILTERS
              Wrap(
                spacing: 10,
                children: ['All', 'Active', 'Completed'].map((filter) {
                  final selected = _selectedFilter == filter;

                  return ChoiceChip(
                    label: Text(filter),
                    selected: selected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.card,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.white70,
                    ),
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // GOAL LIST
              if (goals.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: AppColors.lightPurple,
                        size: 45,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No goals found',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Create a goal and start tracking your progress.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                )
              else
                ...goals.map(
                  (goal) => _GoalCard(
                    goal: goal,
                    onProgressChanged: (value) {
                      viewModel.updateProgress(goal.id, value);
                    },
                    onEdit: () => _showGoalDialog(
                      context,
                      goal: goal,
                    ),
                    onDelete: () => _confirmDelete(
                      context,
                      goal,
                      viewModel,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // CREATE AND EDIT GOAL
  Future<void> _showGoalDialog(
    BuildContext context, {
    Goal? goal,
  }) async {
    final titleController = TextEditingController(
      text: goal?.title ?? '',
    );

    final descriptionController = TextEditingController(
      text: goal?.description ?? '',
    );

    String category = goal?.category ?? 'Academic';

    DateTime deadline = goal?.deadline ??
        DateTime.now().add(const Duration(days: 7));

    // Get the ViewModel BEFORE the asynchronous dialog.
    final viewModel = context.read<GoalViewModel>();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.card,
              title: Text(
                goal == null ? 'Create Goal' : 'Edit Goal',
                style: const TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Goal title',
                        labelStyle: TextStyle(color: Colors.white60),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white60),
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      initialValue: category,
                      dropdownColor: AppColors.card,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.white60),
                      ),
                      items: ['Academic', 'Personal', 'Career', 'Health']
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            category = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Deadline',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${deadline.day}/${deadline.month}/${deadline.year}',
                        style: const TextStyle(color: Colors.white60),
                      ),
                      trailing: const Icon(
                        Icons.calendar_month,
                        color: AppColors.lightPurple,
                      ),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: dialogContext,
                          initialDate: deadline.isBefore(DateTime.now())
                              ? DateTime.now()
                              : deadline,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (picked != null) {
                          setDialogState(() {
                            deadline = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) {
                      return;
                    }

                    Navigator.pop(dialogContext, true);
                  },
                  child: Text(goal == null ? 'Create' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true && mounted) {
      if (goal == null) {
        viewModel.addGoal(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          category: category,
          deadline: deadline,
        );
      } else {
        viewModel.updateGoal(
          goal.copyWith(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            category: category,
            deadline: deadline,
          ),
        );
      }
    }

    titleController.dispose();
    descriptionController.dispose();
  }

  // DELETE GOAL
  Future<void> _confirmDelete(
    BuildContext context,
    Goal goal,
    GoalViewModel viewModel,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Delete Goal?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete "${goal.title}"?',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      viewModel.deleteGoal(goal.id);
    }
  }
}

// SUMMARY CARD
class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
            size: 28,
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// GOAL CARD
class _GoalCard extends StatelessWidget {
  final Goal goal;
  final ValueChanged<double> onProgressChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _GoalCard({
    required this.goal,
    required this.onProgressChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final daysRemaining =
        goal.deadline.difference(DateTime.now()).inDays;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
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
                  goal.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white70,
                ),
                color: AppColors.card,
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            goal.description,
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: Text(goal.category),
                backgroundColor:
                    AppColors.primary.withValues(alpha: 0.2),
                labelStyle: const TextStyle(
                  color: AppColors.lightPurple,
                ),
              ),
              Chip(
                label: Text(
                  goal.isCompleted
                      ? 'Completed'
                      : daysRemaining < 0
                          ? 'Overdue'
                          : daysRemaining == 0
                              ? 'Due today'
                              : '$daysRemaining days left',
                ),
                backgroundColor: goal.isCompleted
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.white12,
                labelStyle: TextStyle(
                  color: goal.isCompleted
                      ? Colors.greenAccent
                      : Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Goal Progress',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                '${(goal.progress * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.lightPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Slider(
            value: goal.progress.clamp(0.0, 1.0),
            min: 0,
            max: 1,
            activeColor: AppColors.primary,
            inactiveColor: Colors.white12,
            onChanged: goal.isCompleted ? null : onProgressChanged,
          ),
          if (!goal.isCompleted)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => onProgressChanged(1.0),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Mark Completed'),
              ),
            ),
        ],
      ),
    );
  }
}
