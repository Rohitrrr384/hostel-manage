import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<LeaveProvider>().fetchLeaveRequests());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final provider = context.watch<LeaveProvider>();
    final requests = provider.getStudentRequests(user?.id ?? 'st1');
    return Scaffold(
      appBar: AppBar(title: const Text('Leave History')),
      body: ResponsivePage(
        onRefresh: () => context.read<LeaveProvider>().fetchLeaveRequests(),
        child: provider.isLoading
            ? const LoadingList()
            : requests.isEmpty
                ? EmptyState(icon: Icons.flight_takeoff, title: 'No leave requests', message: 'Your submitted leave applications will appear here.', actionLabel: 'Apply Leave', onAction: () => Navigator.pushNamed(context, '/student/leave'))
                : Column(
                    children: requests
                        .map((r) => Card(
                              child: ListTile(
                                leading: const Icon(Icons.flight_takeoff),
                                title: Text(AppConstants.leaveTypeNames[r.type] ?? r.type.name),
                                subtitle: Text('${formatDate(r.departureDate)} to ${formatDate(r.returnDate)} • ${r.reason}'),
                                trailing: StatusChip(label: r.status.name),
                              ),
                            ))
                        .toList(),
                  ),
      ),
    );
  }
}
