import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class ComplaintHistoryScreen extends StatefulWidget {
  const ComplaintHistoryScreen({super.key});

  @override
  State<ComplaintHistoryScreen> createState() => _ComplaintHistoryScreenState();
}

class _ComplaintHistoryScreenState extends State<ComplaintHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<ComplaintProvider>().fetchComplaints());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final provider = context.watch<ComplaintProvider>();
    final complaints = provider.getStudentComplaints(user?.id ?? 'st1');
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint History')),
      body: ResponsivePage(
        onRefresh: () => context.read<ComplaintProvider>().fetchComplaints(),
        child: provider.isLoading
            ? const LoadingList()
            : complaints.isEmpty
                ? EmptyState(icon: Icons.construction, title: 'No complaints yet', message: 'Maintenance tickets and updates will show here.', actionLabel: 'Raise Complaint', onAction: () => Navigator.pushNamed(context, '/student/complaints'))
                : Column(
                    children: complaints
                        .map((c) => Card(
                              child: ListTile(
                                leading: Icon(getComplaintCategoryIcon(c.category), color: getPriorityColor(c.priority)),
                                title: Text(c.title),
                                subtitle: Text('${AppConstants.complaintCategoryNames[c.category]} • ${timeAgo(c.createdAt)}\n${c.description}'),
                                isThreeLine: true,
                                trailing: StatusChip(label: c.status.name, color: getStatusColor(c.status.name)),
                              ),
                            ))
                        .toList(),
                  ),
      ),
    );
  }
}
