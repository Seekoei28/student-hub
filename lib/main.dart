
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentHubApp());
}

// STUDENTHUB COLOURS
const Color backgroundColor = Color(0xFF0B0B16);
const Color cardColor = Color(0xFF1A1A2E);
const Color primaryPurple = Color(0xFF873BFF);
const Color lightPurple = Color(0xFFC084FC);

class StudentHubApp extends StatelessWidget {
  const StudentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentHub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryPurple,
          secondary: lightPurple,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// NAVIGATION OPTIONS
const List<Map<String, dynamic>> navigationItems = [
  {'title': 'Dashboard', 'icon': Icons.dashboard},
  {'title': 'Study Rooms', 'icon': Icons.groups},
  {'title': 'My Notes', 'icon': Icons.description},
  {'title': 'Progress', 'icon': Icons.trending_up},
  {'title': 'Events', 'icon': Icons.event},
  {'title': 'Applications', 'icon': Icons.assignment},
  {'title': 'Noticeboard', 'icon': Icons.campaign},
  {'title': 'Settings', 'icon': Icons.settings},
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Close the mobile drawer after selecting a page.
    if (Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  Widget buildSidebar() {
    return Container(
      width: 220,
      color: cardColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.school,
            size: 42,
            color: primaryPurple,
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
      drawer: Drawer(
        backgroundColor: cardColor,
        child: SafeArea(child: buildSidebar()),
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
                          color: cardColor,
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
                                color: primaryPurple,
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
                              : SimplePage(
                                  title: navigationItems[selectedIndex]
                                      ['title'],
                                  icon: navigationItems[selectedIndex]
                                      ['icon'],
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

// SIDEBAR ITEM
class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    this.selected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: selected ? primaryPurple : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13),
        ),
        onTap: onTap,
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
              backgroundColor: primaryPurple,
              child: Icon(Icons.person),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // WELCOME CARD
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF5420B5),
                Color(0xFF24113F),
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
                  color: lightPurple,
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

        // ACADEMIC PROGRESS
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: primaryPurple.withValues(alpha: 0.35),
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
                valueColor: AlwaysStoppedAnimation(primaryPurple),
              ),
              SizedBox(height: 12),
              Text(
                '78% progress - Keep pushing!',
                style: TextStyle(color: lightPurple),
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

// STARTER PAGE FOR EACH SECTION
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
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: primaryPurple.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: primaryPurple,
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
                    color: lightPurple,
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

// STATISTICS CARD
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: lightPurple, size: 28),
          const SizedBox(height: 15),
          Text(title, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: lightPurple,
            ),
          ),
        ],
      ),
    );
  }
}

// FEATURE CARD
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryPurple.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryPurple, size: 36),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
