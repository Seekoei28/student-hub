
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Campus Events',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay connected with what is happening on campus.',
            style: TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 25),

          // FEATURED EVENT
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
                  Icons.event_available,
                  color: Colors.white,
                  size: 38,
                ),
                SizedBox(height: 15),
                Text(
                  'Never Miss an Event!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Discover academic activities, student '
                  'gatherings and campus experiences.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // EVENT CATEGORIES
          const Text(
            'Explore Categories',
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
                title: 'Academic',
                icon: Icons.school,
              ),
              _CategoryChip(
                title: 'Social',
                icon: Icons.groups,
              ),
              _CategoryChip(
                title: 'Workshops',
                icon: Icons.computer,
              ),
              _CategoryChip(
                title: 'Sports',
                icon: Icons.sports_soccer,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // UPCOMING EVENTS
          const Text(
            'Upcoming Events',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          const _EventCard(
            title: 'Technology Innovation Workshop',
            category: 'Workshop',
            date: '18 November 2026',
            time: '10:00 AM',
            venue: 'Computer Laboratory',
            icon: Icons.computer,
          ),

          const _EventCard(
            title: 'Student Networking Day',
            category: 'Social',
            date: '21 November 2026',
            time: '12:00 PM',
            venue: 'Student Centre',
            icon: Icons.groups,
          ),

          const _EventCard(
            title: 'Academic Career Seminar',
            category: 'Academic',
            date: '25 November 2026',
            time: '09:00 AM',
            venue: 'Main Auditorium',
            icon: Icons.school,
          ),

          const _EventCard(
            title: 'Campus Sports Day',
            category: 'Sports',
            date: '28 November 2026',
            time: '08:00 AM',
            venue: 'Sports Grounds',
            icon: Icons.sports_soccer,
          ),
        ],
      ),
    );
  }
}

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

class _EventCard extends StatelessWidget {
  final String title;
  final String category;
  final String date;
  final String time;
  final String venue;
  final IconData icon;

  const _EventCard({
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.venue,
    required this.icon,
  });

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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.lightPurple,
                  size: 26,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.lightPurple,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _eventDetail(Icons.calendar_month, date),
          const SizedBox(height: 9),
          _eventDetail(Icons.access_time, time),
          const SizedBox(height: 9),
          _eventDetail(Icons.location_on, venue),
        ],
      ),
    );
  }

  Widget _eventDetail(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white54,
          size: 16,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
