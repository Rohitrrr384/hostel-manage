import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class ComplaintManagementScreen extends StatefulWidget {
  const ComplaintManagementScreen({super.key});

  @override
  State<ComplaintManagementScreen> createState() => _ComplaintManagementScreenState();
}

class _ComplaintManagementScreenState extends State<ComplaintManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<ComplaintProvider>().fetchComplaints());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ComplaintProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint Management')),
      body: ResponsivePage(
        onRefresh: () => context.read<ComplaintProvider>().fetchComplaints(),
        child: provider.isLoading
            ? const LoadingList()
            : Column(children: provider.complaints.map((c) => Card(child: ListTile(
                  leading: Icon(getComplaintCategoryIcon(c.category), color: getPriorityColor(c.priority)),
                  title: Text(c.title),
                  subtitle: Text('${c.studentName} • ${c.roomNumber}\n${c.description}'),
                  isThreeLine: true,
                  trailing: PopupMenuButton<ComplaintStatus>(
                    initialValue: c.status,
                    onSelected: (s) => context.read<ComplaintProvider>().updateStatus(c.id, s, assignedTo: 'Maintenance Team'),
                    itemBuilder: (_) => ComplaintStatus.values.map((s) => PopupMenuItem(value: s, child: Text(s.name))).toList(),
                  ),
                ))).toList()),
      ),
    );
  }
}
