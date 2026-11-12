
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NoticeboardScreen extends StatelessWidget {
  const NoticeboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Noticeboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.campaign,
                  color: Colors.white,
                  size: 38,
                ),
                SizedBox(height: 15),
                Text(
                  'Important Announcements',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Check regularly for important updates, '
                  'academic information and student notices.',
                  style: TextStyle(color: Colors.white70),
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
            children: const [
              _CategoryChip(
                title: 'All Notices',
                icon: Icons.dashboard,
              ),
              _CategoryChip(
                title: 'Academic',
                icon: Icons.school,
              ),
              _CategoryChip(
                title: 'Examinations',
                icon: Icons.edit_document,
              ),
              _CategoryChip(
                title: 'General',
                icon: Icons.info_outline,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // LATEST NOTICES
          const Text(
            'Latest Announcements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          const _NoticeCard(
            title: 'Examination Timetable Released',
            description:
                'Students are encouraged to check the examination '
                'timetable and prepare for their upcoming assessments.',
            category: 'Examinations',
            date: '12 November 2026',
            priority: 'Important',
          ),

          const _NoticeCard(
            title: 'Assignment Submission Reminder',
            description:
                'Remember to submit your outstanding assignments '
                'before the relevant module deadlines.',
            category: 'Academic',
            date: '10 November 2026',
            priority: 'Reminder',
          ),

          const _NoticeCard(
            title: 'Student Registration Information',
            description:
                'Keep your student information and contact details '
                'up to date through the student administration office.',
            category: 'General',
            date: '08 November 2026',
            priority: 'General',
          ),

          const _NoticeCard(
            title: 'Library Operating Hours',
            description:
                'Please take note of the library operating hours '
                'during the examination preparation period.',
            category: 'General',
            date: '05 November 2026',
            priority: 'General',
          ),
        ],
      ),
    );
  }
}

// CATEGORY CHIP
class _CategoryChip extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CategoryChip({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
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
    );
  }
}

// NOTICE CARD
class _NoticeCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String date;
  final String priority;

  const _NoticeCard({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.priority,
  });

  Color get priorityColor {
    switch (priority) {
      case 'Important':
        return Colors.redAccent;
      case 'Reminder':
        return Colors.orangeAccent;
      default:
        return AppColors.lightPurple;
    }
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
                  category.toUpperCase(),
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
                  priority,
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
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            description,
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
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
