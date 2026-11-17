
import 'package:flutter/material.dart';
import 'constants/app_colors.dart';
import 'views/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'viewmodels/student_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentViewModel(),
      child: const StudentHubApp(),
    ),
  );
}

class StudentHubApp extends StatelessWidget {
  const StudentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentHub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.lightPurple,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
