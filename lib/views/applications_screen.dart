
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Applications',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore opportunities and manage your applications.',
            style: TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 25),

          // APPLICATION SUMMARY
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _SummaryCard(
                title: 'Total',
                value: '04',
                icon: Icons.assignment,
              ),
              _SummaryCard(
                title: 'Pending',
                value: '02',
                icon: Icons.hourglass_top,
              ),
              _SummaryCard(
                title: 'Approved',
                value: '01',
                icon: Icons.check_circle,
              ),
            ],
          ),

          const SizedBox(height: 30),

          // AVAILABLE OPPORTUNITIES
          const Text(
            'Available Opportunities',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          _OpportunityCard(
            title: 'Flutter Development Assistant',
            module: 'Technical Programming III',
            level: 'Third Year',
            icon: Icons.phone_android,
          ),
          _OpportunityCard(
            title: 'Database Assistant',
            module: 'Database Management',
            level: 'Second Year',
            icon: Icons.storage,
          ),
          _OpportunityCard(
            title: 'Networking Assistant',
            module: 'Communication Networks',
            level: 'Third Year',
            icon: Icons.wifi,
          ),

          const SizedBox(height: 30),

          // MY APPLICATIONS
          const Text(
            'Recent Applications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          const _ApplicationCard(
            title: 'Flutter Development Assistant',
            module: 'TPG316C',
            status: 'Pending',
          ),
          const _ApplicationCard(
            title: 'Database Assistant',
            module: 'DBM316C',
            status: 'Approved',
          ),
          const _ApplicationCard(
            title: 'Networking Assistant',
            module: 'CMN316C',
            status: 'Rejected',
          ),
        ],
      ),
    );
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
      width: 150,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.lightPurple, size: 25),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
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

// OPPORTUNITY CARD
class _OpportunityCard extends StatelessWidget {
  final String title;
  final String module;
  final String level;
  final IconData icon;

  const _OpportunityCard({
    required this.title,
    required this.module,
    required this.level,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
          Row(
            children: [
              Icon(icon, color: AppColors.lightPurple, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            module,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            level,
            style: const TextStyle(
              color: AppColors.lightPurple,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Apply Now'),
            ),
          ),
        ],
      ),
    );
  }
}

// APPLICATION STATUS CARD
class _ApplicationCard extends StatelessWidget {
  final String title;
  final String module;
  final String status;

  const _ApplicationCard({
    required this.title,
    required this.module,
    required this.status,
  });

  Color get statusColor {
    switch (status) {
      case 'Approved':
        return Colors.greenAccent;
      case 'Rejected':
        return Colors.redAccent;
      default:
        return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.assignment_outlined,
            color: AppColors.lightPurple,
            size: 27,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  module,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
