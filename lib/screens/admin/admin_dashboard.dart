import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      drawer: const AppDrawer(role: 'admin', destinations: [
        DrawerDestination('Dashboard', '/admin', Icons.dashboard),
        DrawerDestination('Users', '/admin/users', Icons.manage_accounts),
        DrawerDestination('Analytics', '/admin/analytics', Icons.analytics),
        DrawerDestination('Hostels', '/admin/hostels', Icons.apartment),
      ]),
      body: ResponsivePage(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Institution Control Center', subtitle: 'Users, hostels, occupancy and high-level performance.', icon: Icons.admin_panel_settings, color: AppTheme.adminColor),
          const SizedBox(height: 16),
          const AdaptiveGrid(children: [
            StatCard(title: 'Active Users', value: '512', icon: Icons.groups, color: AppTheme.adminColor),
            StatCard(title: 'Rooms', value: '186', icon: Icons.meeting_room, color: AppTheme.info),
            StatCard(title: 'Occupancy', value: '91%', icon: Icons.hotel, color: AppTheme.success),
            StatCard(title: 'Pending Fees', value: '28', icon: Icons.payments, color: AppTheme.warning),
          ]),
          const SectionTitle(title: 'Admin Modules'),
          AdaptiveGrid(minTileWidth: 320, childAspectRatio: 2.6, children: [
            FeatureTile(title: 'User Management', subtitle: 'Create roles and control access', icon: Icons.manage_accounts, color: AppTheme.adminColor, onTap: () => Navigator.pushNamed(context, '/admin/users')),
            FeatureTile(title: 'Analytics', subtitle: 'Hostel health and trends', icon: Icons.analytics, color: AppTheme.info, onTap: () => Navigator.pushNamed(context, '/admin/analytics')),
            FeatureTile(title: 'Hostel Management', subtitle: 'Blocks, rooms and occupancy', icon: Icons.apartment, color: AppTheme.success, onTap: () => Navigator.pushNamed(context, '/admin/hostels')),
          ]),
        ]),
      ),
    );
  }
}
