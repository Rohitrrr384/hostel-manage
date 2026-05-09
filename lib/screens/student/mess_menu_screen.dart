import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class MessMenuScreen extends StatefulWidget {
  final bool showAppBar;
  const MessMenuScreen({super.key, this.showAppBar = true});

  @override
  State<MessMenuScreen> createState() => _MessMenuScreenState();
}

class _MessMenuScreenState extends State<MessMenuScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<MessProvider>().fetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessProvider>();
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(title: const Text('Mess Menu')) : null,
      body: ResponsivePage(
        onRefresh: () => context.read<MessProvider>().fetchMenu(),
        child: provider.isLoading
            ? const LoadingList()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientHeader(title: 'Weekly Mess Menu', subtitle: 'Track meals and update attendance for today.', icon: Icons.restaurant_menu, color: AppColors.mess),
                  const SizedBox(height: 16),
                  if (provider.todayAttendance != null) _AttendanceCard(attendance: provider.todayAttendance!),
                  const SectionTitle(title: 'Meals'),
                  ...provider.menus.map((m) => _MenuCard(menu: m)),
                ],
              ),
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final MealAttendance attendance;
  const _AttendanceCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    Widget meal(String label, bool value) => Chip(
          avatar: Icon(value ? Icons.check_circle : Icons.cancel, size: 18, color: value ? AppTheme.success : AppTheme.error),
          label: Text(label),
        );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(spacing: 8, runSpacing: 8, children: [
          meal('Breakfast', attendance.breakfast),
          meal('Lunch', attendance.lunch),
          meal('Snacks', attendance.snacks),
          meal('Dinner', attendance.dinner),
        ]),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final MessMenu menu;
  const _MenuCard({required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(backgroundColor: AppColors.mess.withOpacity(.12), child: const Icon(Icons.restaurant, color: AppColors.mess)),
        title: Text(formatDate(menu.date)),
        subtitle: Text(menu.date.day == DateTime.now().day ? 'Today' : '${menu.breakfast} • ${menu.dinner}'),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _meal('Breakfast', menu.breakfastItems),
          _meal('Lunch', menu.lunchItems),
          _meal('Snacks', menu.snacksItems),
          _meal('Dinner', menu.dinnerItems),
        ],
      ),
    );
  }

  Widget _meal(String name, List<String> items) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 88, child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(child: Text(items.join(', '))),
        ]),
      );
}
