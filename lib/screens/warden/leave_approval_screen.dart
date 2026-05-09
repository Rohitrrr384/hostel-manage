import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class LeaveApprovalScreen extends StatefulWidget {
  const LeaveApprovalScreen({super.key});

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<LeaveProvider>().fetchLeaveRequests());
  }

  Future<void> _decide(String id, LeaveStatus status) async {
    await context.read<LeaveProvider>().updateStatus(id, status, comment: status == LeaveStatus.approved ? 'Approved by warden' : 'Not approved');
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Leave ${status.name}')));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeaveProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Approvals')),
      body: ResponsivePage(
        onRefresh: () => context.read<LeaveProvider>().fetchLeaveRequests(),
        child: provider.isLoading
            ? const LoadingList()
            : Column(children: provider.requests.map((r) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Expanded(child: Text(r.studentName, style: Theme.of(context).textTheme.titleLarge)), StatusChip(label: r.status.name)]),
                  const SizedBox(height: 6),
                  Text('${r.roomNumber} • ${AppConstants.leaveTypeNames[r.type]} • ${formatDate(r.departureDate)} to ${formatDate(r.returnDate)}'),
                  Text(r.reason),
                  if (r.status == LeaveStatus.pending) ButtonBar(children: [
                    OutlinedButton(onPressed: () => _decide(r.id, LeaveStatus.rejected), child: const Text('Reject')),
                    FilledButton(onPressed: () => _decide(r.id, LeaveStatus.approved), child: const Text('Approve')),
                  ]),
                ])))).toList()),
      ),
    );
  }
}
