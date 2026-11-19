
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../viewmodels/application_viewmodel.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final applicationViewModel =
        Provider.of<ApplicationViewModel>(context);

    final opportunities = applicationViewModel.opportunities;
    final applications = applicationViewModel.applications;

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
            children: [
              _SummaryCard(
                title: 'Total',
                value: applicationViewModel.totalApplications
                    .toString()
                    .padLeft(2, '0'),
                icon: Icons.assignment,
              ),
              _SummaryCard(
                title: 'Pending',
                value: applicationViewModel.pendingApplications
                    .toString()
                    .padLeft(2, '0'),
                icon: Icons.hourglass_top,
              ),
              _SummaryCard(
                title: 'Approved',
                value: applicationViewModel.approvedApplications
                    .toString()
                    .padLeft(2, '0'),
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

          ...opportunities.map((opportunity) {
            final hasApplied =
                applicationViewModel.hasApplied(opportunity.id);

            return _OpportunityCard(
              title: opportunity.title,
              module: opportunity.module,
              level: opportunity.academicLevel,
              icon: _getOpportunityIcon(opportunity.moduleCode),
              hasApplied: hasApplied,
              onApply: () {
                final success = applicationViewModel
                    .applyForOpportunity(opportunity.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Application submitted successfully!'
                          : 'You have already applied for this opportunity.',
                    ),
                    backgroundColor:
                        success ? Colors.green : Colors.orange,
                  ),
                );
              },
            );
          }),

          const SizedBox(height: 30),

          // RECENT APPLICATIONS
          const Text(
            'Recent Applications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          if (applications.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    color: AppColors.lightPurple,
                    size: 40,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No applications yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Apply for an available opportunity to see it here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          else
            ...applications.map((application) {
              return _ApplicationCard(
                title: application.title,
                module: application.moduleCode,
                status: application.status,
              );
            }),
        ],
      ),
    );
  }

  // SELECT ICON BASED ON MODULE
  IconData _getOpportunityIcon(String moduleCode) {
    switch (moduleCode) {
      case 'TPG316C':
        return Icons.phone_android;
      case 'DBM316C':
        return Icons.storage;
      case 'CMN316C':
        return Icons.wifi;
      default:
        return Icons.school;
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
      width: 150,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.lightPurple,
            size: 25,
          ),
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
  final bool hasApplied;
  final VoidCallback onApply;

  const _OpportunityCard({
    required this.title,
    required this.module,
    required this.level,
    required this.icon,
    required this.hasApplied,
    required this.onApply,
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
              Icon(
                icon,
                color: AppColors.lightPurple,
                size: 28,
              ),
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
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
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
              onPressed: hasApplied ? null : onApply,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.green.withValues(
                  alpha: 0.3,
                ),
                disabledForegroundColor: Colors.white,
              ),
              child: Text(
                hasApplied ? 'Applied' : 'Apply Now',
              ),
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
