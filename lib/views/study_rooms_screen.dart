
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../models/study_room.dart';
import '../viewmodels/study_room_viewmodel.dart';

class StudyRoomsScreen extends StatefulWidget {
  const StudyRoomsScreen({super.key});

  @override
  State<StudyRoomsScreen> createState() => _StudyRoomsScreenState();
}

class _StudyRoomsScreenState extends State<StudyRoomsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  final String _studentId = 'student_001';

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  IconData _getRoomIcon(String module) {
    final value = module.toLowerCase();

    if (value.contains('flutter') ||
        value.contains('programming')) {
      return Icons.phone_android;
    }

    if (value.contains('database')) {
      return Icons.storage;
    }

    if (value.contains('software')) {
      return Icons.code;
    }

    if (value.contains('network')) {
      return Icons.wifi;
    }

    return Icons.groups;
  }

  void _showCreateRoomDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final moduleController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Create Study Room',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogField(nameController, 'Room name'),
                const SizedBox(height: 12),
                _dialogField(
                  descriptionController,
                  'Description',
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                _dialogField(moduleController, 'Module'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                nameController.dispose();
                descriptionController.dispose();
                moduleController.dispose();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final name = nameController.text.trim();
                final description =
                    descriptionController.text.trim();
                final module = moduleController.text.trim();

                if (name.isEmpty ||
                    description.isEmpty ||
                    module.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete all fields.'),
                    ),
                  );
                  return;
                }

                context.read<StudyRoomViewModel>().createRoom(
                      name: name,
                      description: description,
                      module: module,
                      createdBy: _studentId,
                    );

                Navigator.pop(dialogContext);

                nameController.dispose();
                descriptionController.dispose();
                moduleController.dispose();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Study room created successfully!'),
                  ),
                );
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _toggleMembership(StudyRoom room, bool isJoined) {
    final viewModel = context.read<StudyRoomViewModel>();

    if (isJoined) {
      viewModel.leaveRoom(room.id, _studentId);
    } else {
      viewModel.joinRoom(room.id, _studentId);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isJoined
              ? 'You left ${room.name}.'
              : 'You joined ${room.name}!',
        ),
      ),
    );
  }

  void _showRoomDetails(StudyRoom room) {
    final isJoined = room.members.contains(_studentId);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: Text(
            room.name,
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.description,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 15),
              Text(
                'Module: ${room.module}',
                style: const TextStyle(
                  color: AppColors.lightPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${room.members.length} students in this room',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isJoined ? Colors.redAccent : AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                _toggleMembership(room, isJoined);
              },
              child: Text(isJoined ? 'Leave Room' : 'Join Room'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRoomCard(StudyRoom room) {
    final isJoined = room.members.contains(_studentId);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getRoomIcon(room.module),
              color: AppColors.lightPurple,
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  room.description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${room.members.length} Students • ${room.module}',
                  style: const TextStyle(
                    color: AppColors.lightPurple,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => _showRoomDetails(room),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.lightPurple,
                        side: const BorderSide(
                          color: AppColors.primary,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      child: const Text('Details'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _toggleMembership(room, isJoined),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isJoined
                            ? Colors.redAccent.withValues(alpha: 0.15)
                            : AppColors.primary,
                        foregroundColor: isJoined
                            ? Colors.redAccent
                            : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      child: Text(
                        isJoined ? 'Leave' : 'Join Room',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.groups_outlined,
            color: AppColors.lightPurple,
            size: 55,
          ),
          const SizedBox(height: 15),
          Text(
            _searchQuery.isEmpty
                ? 'No Study Rooms Yet'
                : 'No Rooms Found',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Create a study room and invite other students.'
                : 'Try searching with another room name or module.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyRoomViewModel>(
      builder: (context, viewModel, child) {
        final filteredRooms =
            viewModel.searchRooms(_searchQuery);

        final joinedCount =
            viewModel.getJoinedRooms(_studentId).length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Study Rooms',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect, collaborate and learn together.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 25),

              // BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                      Icons.groups_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Study Better Together',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Join other students, share knowledge and '
                      'prepare for your upcoming assessments.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // SUMMARY
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Available Rooms',
                      '${viewModel.rooms.length}',
                      Icons.meeting_room_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      'My Rooms',
                      '$joinedCount',
                      Icons.groups_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // SEARCH
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search study rooms...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightPurple,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
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
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // SECTION HEADER
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Available Study Rooms',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showCreateRoomDialog,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Create'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                '${filteredRooms.length} rooms found',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 15),

              if (filteredRooms.isEmpty)
                _buildEmptyState()
              else
                ...filteredRooms.map(_buildRoomCard),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(
    String title,
    String count,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.lightPurple,
            size: 24,
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
