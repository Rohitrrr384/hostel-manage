import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class MessDashboard extends StatefulWidget {
  const MessDashboard({super.key});

  @override
  State<MessDashboard> createState() => _MessDashboardState();
}

class _MessDashboardState extends State<MessDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<MessProvider>().fetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    final mess = context.watch<MessProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Mess Dashboard')),
      drawer: const AppDrawer(role: 'mess', destinations: [
        DrawerDestination('Dashboard', '/mess', Icons.dashboard),
        DrawerDestination('Menu Management', '/mess/menu', Icons.restaurant_menu),
        DrawerDestination('Meal Attendance', '/mess/attendance', Icons.fact_check),
        DrawerDestination('Feedback', '/mess/feedback', Icons.rate_review),
      ]),
      body: ResponsivePage(
        onRefresh: () => context.read<MessProvider>().fetchMenu(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Mess Operations', subtitle: 'Menu planning, attendance and meal quality feedback.', icon: Icons.restaurant, color: AppTheme.messColor),
          const SizedBox(height: 16),
          AdaptiveGrid(children: [
            StatCard(title: 'Menus Scheduled', value: '${mess.menus.length}', icon: Icons.calendar_month, color: AppTheme.messColor),
            const StatCard(title: 'Breakfast Count', value: '382', icon: Icons.free_breakfast, color: AppTheme.info),
            const StatCard(title: 'Lunch Count', value: '417', icon: Icons.lunch_dining, color: AppTheme.success),
            const StatCard(title: 'Avg Rating', value: '4.2', icon: Icons.star, color: AppTheme.warning),
          ]),
          const SectionTitle(title: 'Tools'),
          AdaptiveGrid(minTileWidth: 320, childAspectRatio: 2.6, children: [
            FeatureTile(title: 'Menu Management', subtitle: 'Review weekly menu plans', icon: Icons.restaurant_menu, color: AppTheme.messColor, onTap: () => Navigator.pushNamed(context, '/mess/menu')),
            FeatureTile(title: 'Meal Attendance', subtitle: 'Expected meal counts for today', icon: Icons.fact_check, color: AppTheme.success, onTap: () => Navigator.pushNamed(context, '/mess/attendance')),
            FeatureTile(title: 'Feedback', subtitle: 'Ratings and comments from students', icon: Icons.rate_review, color: AppTheme.warning, onTap: () => Navigator.pushNamed(context, '/mess/feedback')),
          ]),
        ]),
      ),
    );
  }
}
