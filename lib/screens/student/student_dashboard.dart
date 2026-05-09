import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';
import 'mess_menu_screen.dart';
import 'notices_screen.dart';
import 'profile_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  Future<void> _refresh() async {
    await Future.wait([
      context.read<LeaveProvider>().fetchLeaveRequests(),
      context.read<ComplaintProvider>().fetchComplaints(),
      context.read<MessProvider>().fetchMenu(),
      context.read<NoticeProvider>().fetchNotices(),
      context.read<LaundryProvider>().fetchSlots(),
      context.read<VisitorProvider>().fetchVisitors(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _StudentHome(onRefresh: _refresh),
      const MessMenuScreen(showAppBar: false),
      const NoticesScreen(showAppBar: false),
      const ProfileScreen(showAppBar: false),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Mess'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign_outlined), label: 'Notices'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _StudentHome extends StatelessWidget {
  final RefreshCallback onRefresh;
  const _StudentHome({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final leaves = context.watch<LeaveProvider>().getStudentRequests(user?.id ?? 'st1');
    final complaints = context.watch<ComplaintProvider>().getStudentComplaints(user?.id ?? 'st1');
    final notices = context.watch<NoticeProvider>().pinnedNotices;
    final laundry = context.watch<LaundryProvider>().getStudentSlots(user?.id ?? 'st1');
    return ResponsivePage(
      onRefresh: onRefresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientHeader(
            title: 'Hi, ${user?.name.split(' ').first ?? 'Student'}',
            subtitle: '${user?.roomNumber ?? 'A-205'} • ${user?.hostelName ?? 'Boys Hostel A'}',
            icon: Icons.school,
            color: AppTheme.studentColor,
            trailing: IconButton.filledTonal(
              tooltip: 'Logout',
              onPressed: () async {
                await context.read<AuthProvider>().logout();
                if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
              icon: const Icon(Icons.logout),
            ),
          ),
          const SizedBox(height: 18),
          AdaptiveGrid(
            children: [
              StatCard(title: 'Leave Requests', value: '${leaves.length}', icon: Icons.flight_takeoff, color: AppColors.leave),
              StatCard(title: 'Open Complaints', value: '${complaints.where((c) => c.status.name != 'resolved').length}', icon: Icons.report_problem_outlined, color: AppColors.complaint),
              StatCard(title: 'Pinned Notices', value: '${notices.length}', icon: Icons.push_pin_outlined, color: AppColors.notice),
              StatCard(title: 'Laundry Slots', value: '${laundry.length}', icon: Icons.local_laundry_service_outlined, color: AppColors.laundry),
            ],
          ),
          const SectionTitle(title: 'Quick Actions'),
          AdaptiveGrid(
            minTileWidth: 320,
            childAspectRatio: 2.7,
            children: [
              FeatureTile(title: 'Apply Leave', subtitle: 'Parent contact, dates, reason', icon: Icons.edit_calendar, color: AppColors.leave, onTap: () => Navigator.pushNamed(context, '/student/leave')),
              FeatureTile(title: 'Raise Complaint', subtitle: 'Maintenance and hostel issues', icon: Icons.construction, color: AppColors.complaint, onTap: () => Navigator.pushNamed(context, '/student/complaints')),
              FeatureTile(title: 'Book Laundry', subtitle: 'Choose date, slot and item count', icon: Icons.local_laundry_service, color: AppColors.laundry, onTap: () => Navigator.pushNamed(context, '/student/laundry')),
              FeatureTile(title: 'Visitor Pass', subtitle: 'Pre-register family or guests', icon: Icons.badge, color: AppColors.visitor, onTap: () => Navigator.pushNamed(context, '/student/visitors')),
              FeatureTile(title: 'Marketplace', subtitle: 'Buy and sell inside hostel', icon: Icons.storefront, color: AppTheme.info, onTap: () => Navigator.pushNamed(context, '/student/marketplace')),
              FeatureTile(title: 'Lost & Found', subtitle: 'Report or recover belongings', icon: Icons.search, color: AppTheme.warning, onTap: () => Navigator.pushNamed(context, '/student/lost-found')),
            ],
          ),
        ],
      ),
    );
  }
}
