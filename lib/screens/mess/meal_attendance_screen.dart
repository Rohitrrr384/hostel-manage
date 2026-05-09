import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class MealAttendanceScreen extends StatelessWidget {
  const MealAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendance = context.watch<MessProvider>().todayAttendance ?? MealAttendance(id: 'a', studentId: 'mock', date: DateTime.now());
    final counts = [
      ('Breakfast', attendance.breakfast, 382, Icons.free_breakfast),
      ('Lunch', attendance.lunch, 417, Icons.lunch_dining),
      ('Snacks', attendance.snacks, 336, Icons.cookie),
      ('Dinner', attendance.dinner, 404, Icons.dinner_dining),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Meal Attendance')),
      body: ResponsivePage(
        child: Column(children: [
          const GradientHeader(title: 'Today Meal Count', subtitle: 'Forecast meals from student attendance preferences.', icon: Icons.fact_check, color: AppTheme.messColor),
          const SizedBox(height: 16),
          AdaptiveGrid(children: counts.map((c) => StatCard(title: c.$1, value: '${c.$3}', icon: c.$4, color: c.$2 ? AppTheme.success : AppTheme.textSecondary)).toList()),
        ]),
      ),
    );
  }
}
