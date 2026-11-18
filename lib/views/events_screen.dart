
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/event.dart';
import '../viewmodels/event_viewmodel.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EventViewModel>(
      builder: (context, eventViewModel, child) {
        final events = eventViewModel.filteredEvents;

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

              // FEATURED EVENT BANNER
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
                      Icons.event_available,
                      color: Colors.white,
                      size: 38,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Never Miss an Event!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Discover academic activities, student '
                      'gatherings and campus experiences.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Icon(
                          Icons.event,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${eventViewModel.totalEvents} Campus Events',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${eventViewModel.registeredCount} Registered',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // SEARCH EVENTS
              TextField(
                onChanged: eventViewModel.searchEvents,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search campus events...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightPurple,
                  ),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
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
                children: [
                  _CategoryChip(
                    title: 'All',
                    icon: Icons.grid_view,
                    selected:
                        eventViewModel.selectedCategory == 'All',
                    onTap: () => eventViewModel.setCategory('All'),
                  ),
                  _CategoryChip(
                    title: 'Academic',
                    icon: Icons.school,
                    selected:
                        eventViewModel.selectedCategory == 'Academic',
                    onTap: () =>
                        eventViewModel.setCategory('Academic'),
                  ),
                  _CategoryChip(
                    title: 'Social',
                    icon: Icons.groups,
                    selected:
                        eventViewModel.selectedCategory == 'Social',
                    onTap: () => eventViewModel.setCategory('Social'),
                  ),
                  _CategoryChip(
                    title: 'Workshops',
                    icon: Icons.computer,
                    selected:
                        eventViewModel.selectedCategory == 'Workshops',
                    onTap: () =>
                        eventViewModel.setCategory('Workshops'),
                  ),
                  _CategoryChip(
                    title: 'Sports',
                    icon: Icons.sports_soccer,
                    selected:
                        eventViewModel.selectedCategory == 'Sports',
                    onTap: () => eventViewModel.setCategory('Sports'),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // UPCOMING EVENTS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${events.length} found',
                    style: const TextStyle(
                      color: AppColors.lightPurple,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              if (events.isEmpty)
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
                        Icons.event_busy,
                        color: AppColors.lightPurple,
                        size: 45,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No events found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Try another search or category.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                )
              else
                ...events.map((event) {
                  return _EventCard(
                    event: event,
                    isRegistered:
                        eventViewModel.isRegistered(event.id),
                    onRegister: () {
                      eventViewModel.registerForEvent(event.id);
                    },
                    onCancel: () {
                      eventViewModel.cancelRegistration(event.id);
                    },
                  );
                }),

              const SizedBox(height: 20),

              // MY REGISTERED EVENTS
              const Text(
                'My Registered Events',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (eventViewModel.registeredEvents.isEmpty)
                const Text(
                  'You have not registered for any events yet.',
                  style: TextStyle(color: Colors.white60),
                )
              else
                ...eventViewModel.registeredEvents.map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.lightPurple,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            event.title,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
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
          color: selected ? AppColors.primary : AppColors.card,
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
              color: Colors.white,
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

// EVENT CARD
class _EventCard extends StatelessWidget {
  final Event event;
  final bool isRegistered;
  final VoidCallback onRegister;
  final VoidCallback onCancel;

  const _EventCard({
    required this.event,
    required this.isRegistered,
    required this.onRegister,
    required this.onCancel,
  });

  IconData get eventIcon {
    switch (event.category.toLowerCase()) {
      case 'academic':
        return Icons.school;
      case 'social':
        return Icons.groups;
      case 'workshops':
        return Icons.computer;
      case 'sports':
        return Icons.sports_soccer;
      default:
        return Icons.event;
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

    return '${event.date.day} '
        '${months[event.date.month - 1]} '
        '${event.date.year}';
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  eventIcon,
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
                      event.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.lightPurple,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      event.title,
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

          Text(
            event.description,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 18),

          _eventDetail(Icons.calendar_month, formattedDate),

          const SizedBox(height: 9),

          _eventDetail(Icons.access_time, event.time),

          const SizedBox(height: 9),

          _eventDetail(Icons.location_on, event.venue),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isRegistered ? onCancel : onRegister,
              icon: Icon(
                isRegistered ? Icons.cancel_outlined : Icons.event_available,
                size: 18,
              ),
              label: Text(
                isRegistered
                    ? 'Cancel Registration'
                    : 'Register for Event',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isRegistered
                    ? AppColors.card
                    : AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: isRegistered
                      ? const BorderSide(color: AppColors.primary)
                      : BorderSide.none,
                ),
              ),
            ),
          ),
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
