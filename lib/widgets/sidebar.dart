
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

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
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppColors.lightPurple : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.grey,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: onTap,
    );
  }
}
