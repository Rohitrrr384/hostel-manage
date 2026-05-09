import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class WardenDashboard extends StatefulWidget {
  const WardenDashboard({super.key});

  @override
  State<WardenDashboard> createState() => _WardenDashboardState();
}

class _WardenDashboardState extends State<WardenDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => Future.wait([
          context.read<LeaveProvider>().fetchLeaveRequests(),
          context.read<ComplaintProvider>().fetchComplaints(),
          context.read<NoticeProvider>().fetchNotices(),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    final leaves = context.watch<LeaveProvider>();
    final complaints = context.watch<ComplaintProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Warden Dashboard')),
      drawer: const _WardenDrawer(),
      body: ResponsivePage(
        onRefresh: () async {
          await context.read<LeaveProvider>().fetchLeaveRequests();
          await context.read<ComplaintProvider>().fetchComplaints();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Hostel Operations', subtitle: 'Approvals, complaints, students and announcements.', icon: Icons.supervisor_account, color: AppTheme.wardenColor),
          const SizedBox(height: 16),
          AdaptiveGrid(children: [
            StatCard(title: 'Pending Leaves', value: '${leaves.getPendingRequests().length}', icon: Icons.pending_actions, color: AppTheme.warning),
            StatCard(title: 'Complaints', value: '${complaints.complaints.length}', icon: Icons.construction, color: AppTheme.error),
            const StatCard(title: 'Occupancy', value: '92%', icon: Icons.hotel, color: AppTheme.wardenColor),
            const StatCard(title: 'Students', value: '428', icon: Icons.groups, color: AppTheme.info),
          ]),
          const SectionTitle(title: 'Manage'),
          AdaptiveGrid(minTileWidth: 320, childAspectRatio: 2.6, children: [
            FeatureTile(title: 'Leave Approvals', subtitle: 'Review pending leave requests', icon: Icons.fact_check, color: AppTheme.warning, onTap: () => Navigator.pushNamed(context, '/warden/leaves')),
            FeatureTile(title: 'Complaints', subtitle: 'Assign and resolve hostel issues', icon: Icons.handyman, color: AppTheme.error, onTap: () => Navigator.pushNamed(context, '/warden/complaints')),
            FeatureTile(title: 'Students', subtitle: 'Room and student directory', icon: Icons.groups, color: AppTheme.wardenColor, onTap: () => Navigator.pushNamed(context, '/warden/students')),
            FeatureTile(title: 'Notices', subtitle: 'Publish hostel announcements', icon: Icons.campaign, color: AppTheme.info, onTap: () => Navigator.pushNamed(context, '/warden/notices')),
          ]),
        ]),
      ),
    );
  }
}

class _WardenDrawer extends StatelessWidget {
  const _WardenDrawer();

  @override
  Widget build(BuildContext context) => const AppDrawer(role: 'warden', destinations: [
        DrawerDestination('Dashboard', '/warden', Icons.dashboard),
        DrawerDestination('Leave Approvals', '/warden/leaves', Icons.fact_check),
        DrawerDestination('Complaints', '/warden/complaints', Icons.handyman),
        DrawerDestination('Students', '/warden/students', Icons.groups),
        DrawerDestination('Notices', '/warden/notices', Icons.campaign),
      ]);
}
