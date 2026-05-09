import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class VisitorVerificationScreen extends StatefulWidget {
  const VisitorVerificationScreen({super.key});

  @override
  State<VisitorVerificationScreen> createState() => _VisitorVerificationScreenState();
}

class _VisitorVerificationScreenState extends State<VisitorVerificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<VisitorProvider>().fetchVisitors());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VisitorProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Verification')),
      body: ResponsivePage(
        onRefresh: () => context.read<VisitorProvider>().fetchVisitors(),
        child: provider.isLoading
            ? const LoadingList()
            : Column(children: provider.visitors.map((v) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Expanded(child: Text(v.visitorName, style: Theme.of(context).textTheme.titleLarge)), StatusChip(label: v.status.name)]),
                  Text('${v.relationship} visiting ${v.studentName} • Room ${v.roomNumber}'),
                  Text('${v.purpose} • ${v.visitorPhone} • ${timeAgo(v.createdAt)}'),
                  ButtonBar(children: [
                    if (v.status == VisitorStatus.pending) FilledButton(onPressed: () => context.read<VisitorProvider>().approveEntry(v.id), child: const Text('Approve Entry')),
                    if (v.status == VisitorStatus.inside) OutlinedButton(onPressed: () => context.read<VisitorProvider>().recordExit(v.id), child: const Text('Record Exit')),
                  ]),
                ])))).toList()),
      ),
    );
  }
}
