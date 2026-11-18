
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/notice.dart';
import '../viewmodels/notice_viewmodel.dart';

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddNoticeDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    String selectedCategory = 'Academic';
    String selectedPriority = 'General';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.card,
              title: const Text(
                'Create Announcement',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Announcement title'),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Description'),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      dropdownColor: AppColors.card,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Category'),
                      items: [
                        'Academic',
                        'Examinations',
                        'General',
                      ].map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                     initialValue: selectedPriority,
                      dropdownColor: AppColors.card,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Priority'),
                      items: [
                        'Important',
                        'Reminder',
                        'General',
                      ].map((priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedPriority = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        descriptionController.text.trim().isEmpty) {
                      return;
                    }

                    context.read<NoticeViewModel>().addNotice(
                          title: titleController.text.trim(),
                          description:
                              descriptionController.text.trim(),
                          category: selectedCategory,
                          priority: selectedPriority,
                        );

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Announcement added successfully!'),
                      ),
                    );
                  },
                  child: const Text(
                    'Publish',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      titleController.dispose();
      descriptionController.dispose();
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white60),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Noticeboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showAddNoticeDialog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Notice'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Stay informed with the latest student announcements.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 25),

              // FEATURED ANNOUNCEMENT
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
                    const Icon(
                      Icons.campaign,
                      color: Colors.white,
                      size: 38,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Important Announcements',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check regularly for important updates, '
                      'academic information and student notices.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${viewModel.unreadCount} unread notices',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // NOTICE CATEGORIES
              const Text(
                'Notice Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _CategoryChip(
                    title: 'All Notices',
                    icon: Icons.dashboard,
                    selected:
                        viewModel.selectedCategory == 'All Notices',
                    onTap: () => viewModel.setCategory('All Notices'),
                  ),
                  _CategoryChip(
                    title: 'Academic',
                    icon: Icons.school,
                    selected:
                        viewModel.selectedCategory == 'Academic',
                    onTap: () => viewModel.setCategory('Academic'),
                  ),
                  _CategoryChip(
                    title: 'Examinations',
                    icon: Icons.edit_document,
                    selected:
                        viewModel.selectedCategory == 'Examinations',
                    onTap: () => viewModel.setCategory('Examinations'),
                  ),
                  _CategoryChip(
                    title: 'General',
                    icon: Icons.info_outline,
                    selected:
                        viewModel.selectedCategory == 'General',
                    onTap: () => viewModel.setCategory('General'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // SEARCH
              TextField(
                controller: _searchController,
                onChanged: viewModel.searchNotices,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search announcements...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightPurple,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            viewModel.searchNotices('');
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
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // LATEST NOTICES
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Latest Announcements',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${viewModel.filteredNotices.length} notices',
                    style: const TextStyle(
                      color: AppColors.lightPurple,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              if (viewModel.filteredNotices.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        color: AppColors.lightPurple,
                        size: 40,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No announcements found',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Try another search or category.',
                        style: TextStyle(color: Colors.white60),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...viewModel.filteredNotices.map(
                  (notice) => _NoticeCard(
                    notice: notice,
                    onToggleRead: () {
                      viewModel.toggleReadStatus(notice.id);
                    },
                    onDelete: () {
                      viewModel.deleteNotice(notice.id);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// CATEGORY CHIP
class _CategoryChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.25)
              : AppColors.card,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.lightPurple,
              size: 17,
            ),
            const SizedBox(width: 7),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// NOTICE CARD
class _NoticeCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback onToggleRead;
  final VoidCallback onDelete;

  const _NoticeCard({
    required this.notice,
    required this.onToggleRead,
    required this.onDelete,
  });

  Color get priorityColor {
    switch (notice.priority) {
      case 'Important':
        return Colors.redAccent;
      case 'Reminder':
        return Colors.orangeAccent;
      default:
        return AppColors.lightPurple;
    }
  }

  String get formattedDate {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final day = notice.date.day.toString().padLeft(2, '0');
    final month = months[notice.date.month - 1];
    return '$day $month ${notice.date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
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
              Expanded(
                child: Text(
                  notice.category.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.lightPurple,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  notice.priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            notice.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
                  notice.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            notice.description,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.white54,
                size: 14,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onToggleRead,
                icon: Icon(
                  notice.isRead
                      ? Icons.mark_email_unread_outlined
                      : Icons.mark_email_read_outlined,
                  size: 16,
                ),
                label: Text(
                  notice.isRead ? 'Unread' : 'Read',
                  style: const TextStyle(fontSize: 11),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.lightPurple,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Delete notice',
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 19,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
