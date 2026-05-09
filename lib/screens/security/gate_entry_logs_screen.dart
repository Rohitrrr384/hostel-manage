import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class GateEntryLogsScreen extends StatelessWidget {
  const GateEntryLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visitors = context.watch<VisitorProvider>().visitors;
    return Scaffold(
      appBar: AppBar(title: const Text('Gate Entry Logs')),
      body: ResponsivePage(
        onRefresh: () => context.read<VisitorProvider>().fetchVisitors(),
        child: Column(children: visitors.map((v) => Card(child: ListTile(leading: const Icon(Icons.receipt_long), title: Text(v.visitorName), subtitle: Text('${v.studentName} • Entry: ${v.entryTime == null ? 'Pending' : formatTime(v.entryTime!)} • Exit: ${v.exitTime == null ? '-': formatTime(v.exitTime!)}'), trailing: StatusChip(label: v.status.name)))).toList()),
      ),
    );
  }
}
