
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/stat_card.dart';
import '../widgets/feature_card.dart';
import 'study_rooms_screen.dart';
import 'notes_screen.dart';
import 'progress_screen.dart';
import 'events_screen.dart';
import 'applications_screen.dart';
import 'noticeboard_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  Widget buildSidebar() {
    return Container(
      width: 220,
      color: AppColors.card,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.school,
            size: 42,
            color: AppColors.primary,
          ),
          const SizedBox(height: 8),
          const Text(
            'StudentHub',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < navigationItems.length; i++)
                    SidebarItem(
                      icon: navigationItems[i]['icon'],
                      title: navigationItems[i]['title'],
                      selected: selectedIndex == i,
                      onTap: () => changePage(i),
                    ),
                ],
              ),
            ),
          ),

          SidebarItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logout will be connected later.'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColors.card,
        child: SafeArea(
          child: buildSidebar(),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 700;

            return Row(
              children: [
                if (!isMobile) buildSidebar(),

                Expanded(
                  child: Column(
                    children: [
                      if (isMobile)
                        Container(
                          color: AppColors.card,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Builder(
                                builder: (context) => IconButton(
                                  icon: const Icon(Icons.menu),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                ),
                              ),
                              const Icon(
                                Icons.school,
                                color: AppColors.primary,
                                size: 28,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'StudentHub',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          

child: selectedIndex == 0
    ? const DashboardContent()
    : selectedIndex == 1
        ? const StudyRoomsScreen()
       : selectedIndex == 2
    ? const NotesScreen()
   : selectedIndex == 3
    ? const ProgressScreen()
    : selectedIndex == 4
    ? const EventsScreen()
    : selectedIndex == 5
    ? const ApplicationsScreen()
   : selectedIndex == 6
    ? const NoticeboardScreen()
    : selectedIndex == 7
        ? const SettingsScreen()
        : SimplePage(
            title: navigationItems[selectedIndex]['title'],
            icon: navigationItems[selectedIndex]['icon'],
          ),


                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// DASHBOARD CONTENT
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'Overview',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.notifications_none, size: 28),
            SizedBox(width: 18),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person),
            ),
          ],
        ),

        const SizedBox(height: 28),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, Student! 👋',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Keep learning, growing and achieving your goals.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 20),
              Text(
                'LEARN • APPLY • CONNECT • EXCEL',
                style: TextStyle(
                  color: AppColors.lightPurple,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          'Your Overview',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            StatCard(
              title: 'Registered Modules',
              value: '4',
              icon: Icons.menu_book,
            ),
            StatCard(
              title: 'Upcoming Events',
              value: '3',
              icon: Icons.calendar_month,
            ),
            StatCard(
              title: 'Assignments',
              value: '2',
              icon: Icons.assignment_turned_in,
            ),
          ],
        ),

        const SizedBox(height: 32),

        const Text(
          'Explore StudentHub',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            FeatureCard(
              icon: Icons.groups,
              title: 'Study Groups',
              subtitle: 'Learn together',
            ),
            FeatureCard(
              icon: Icons.calendar_month,
              title: 'Smart Calendar',
              subtitle: 'Manage deadlines',
            ),
            FeatureCard(
              icon: Icons.campaign,
              title: 'Noticeboard',
              subtitle: 'Latest updates',
            ),
            FeatureCard(
              icon: Icons.work,
              title: 'Student Assistant',
              subtitle: 'Track applications',
            ),
            FeatureCard(
              icon: Icons.bar_chart,
              title: 'Study Progress',
              subtitle: 'Track your growth',
            ),
            FeatureCard(
              icon: Icons.sticky_note_2,
              title: 'My Notes',
              subtitle: 'Save study notes',
            ),
          ],
        ),

        const SizedBox(height: 32),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Academic Journey',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              LinearProgressIndicator(
                value: 0.78,
                minHeight: 10,
                backgroundColor: Color(0xFF333044),
                valueColor: AlwaysStoppedAnimation(
                  AppColors.primary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '78% progress - Keep pushing!',
                style: TextStyle(
                  color: AppColors.lightPurple,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        const Center(
          child: Text(
            'StudentHub • Learn. Grow. Succeed.',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

// TEMPORARY STARTER PAGE
class SimplePage extends StatelessWidget {
  final String title;
  final IconData icon;

  const SimplePage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 28),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: AppColors.primary,
                  size: 65,
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your $title page is ready for development.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'More features coming soon!',
                  style: TextStyle(
                    color: AppColors.lightPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
