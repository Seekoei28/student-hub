
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/notice.dart';
import '../viewmodels/notice_viewmodel.dart';

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  State<NoticeboardScreen> createState() =>
      _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddNoticeDialog(BuildContext context) {
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
                'Create New Notice',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Notice title'),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration:
                          _inputDecoration('Notice description'),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      dropdownColor: AppColors.card,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Category'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Academic',
                          child: Text('Academic'),
                        ),
                        DropdownMenuItem(
                          value: 'Examinations',
                          child: Text('Examinations'),
                        ),
                        DropdownMenuItem(
                          value: 'General',
                          child: Text('General'),
                        ),
                      ],
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
                      items: const [
                        DropdownMenuItem(
                          value: 'Important',
                          child: Text('Important'),
                        ),
                        DropdownMenuItem(
                          value: 'Reminder',
                          child: Text('Reminder'),
                        ),
                        DropdownMenuItem(
                          value: 'General',
                          child: Text('General'),
                        ),
                      ],
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
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        descriptionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please complete all fields.',
                          ),
                        ),
                      );
                      return;
                    }

                    Provider.of<NoticeViewModel>(
                      context,
                      listen: false,
                    ).addNotice(
                      title: titleController.text.trim(),
                      description:
                          descriptionController.text.trim(),
                      category: selectedCategory,
                      priority: selectedPriority,
                    );

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notice added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Add Notice'),
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
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeViewModel>(
      builder: (context, noticeViewModel, child) {
        final notices = noticeViewModel.filteredNotices;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PAGE HEADER
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
                  IconButton(
                    onPressed: () =>
                        _showAddNoticeDialog(context),
                    icon: const Icon(
                      Icons.add_circle,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    tooltip: 'Add Notice',
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Stay updated with the latest campus announcements.',
                style: TextStyle(color: Colors.white60),
              ),

              const SizedBox(height: 25),

              // FEATURED ANNOUNCEMENT
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradientStart,
                      AppColors.gradientEnd,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.campaign,
                          color: AppColors.lightPurple,
                          size: 27,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'CAMPUS ANNOUNCEMENTS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Stay Informed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check the noticeboard regularly so you never '
                      'miss important academic updates, examination '
                      'information and campus announcements.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.mark_email_unread_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${noticeViewModel.unreadCount} unread notices',
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

              const SizedBox(height: 28),

              // SEARCH
              TextField(
                controller: _searchController,
                onChanged: noticeViewModel.searchNotices,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search notices...',
                  hintStyle:
                      const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightPurple,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            noticeViewModel.searchNotices('');
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white60,
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

              const SizedBox(height: 22),

              // CATEGORY FILTERS
              const Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'All Notices',
                    'Academic',
                    'Examinations',
                    'General',
                  ].map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _CategoryChip(
                        title: category,
                        selected:
                            noticeViewModel.selectedCategory ==
                                category,
                        onTap: () {
                          noticeViewModel.setCategory(category);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 25),

              // NOTICE LIST HEADER
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Latest Notices',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${notices.length} notices',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // NOTICE LIST
              if (notices.isEmpty)
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
                        Icons.notifications_off_outlined,
                        color: AppColors.lightPurple,
                        size: 45,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No notices found',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Try another search or category.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...notices.map(
                  (notice) => _NoticeCard(
                    notice: notice,
                    onToggleRead: () {
                      noticeViewModel.toggleReadStatus(notice.id);
                    },
                    onDelete: () {
                      noticeViewModel.deleteNotice(notice.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notice deleted.'),
                        ),
                      );
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
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
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
    final date = notice.date;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: notice.isRead
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.primary.withValues(alpha: 0.45),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  notice.priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                notice.category,
                style: const TextStyle(
                  color: AppColors.lightPurple,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              if (!notice.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            notice.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
                  notice.isRead ? FontWeight.w500 : FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            notice.description,
            style: const TextStyle(
              color: Colors.white70,
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
              const SizedBox(width: 6),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onToggleRead,
                tooltip: notice.isRead
                    ? 'Mark as unread'
                    : 'Mark as read',
                icon: Icon(
                  notice.isRead
                      ? Icons.mark_email_unread_outlined
                      : Icons.mark_email_read_outlined,
                  color: AppColors.lightPurple,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Delete notice',
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
