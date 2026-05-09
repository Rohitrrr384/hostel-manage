import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class HostelManagementScreen extends StatelessWidget {
  const HostelManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blocks = const [
      ('Block A', '104/112', 'Boys Hostel A'),
      ('Block B', '98/108', 'Girls Hostel B'),
      ('Block C', '86/96', 'Boys Hostel C'),
      ('Block D', '72/96', 'Transit Hostel'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Hostel Management'), actions: [IconButton(tooltip: 'Add block', icon: const Icon(Icons.add_business), onPressed: () {})]),
      body: ResponsivePage(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Hostels & Rooms', subtitle: 'Manage blocks, capacity, rooms and occupancy planning.', icon: Icons.apartment, color: AppTheme.adminColor),
          const SizedBox(height: 16),
          ...blocks.map((b) => Card(child: ListTile(leading: const Icon(Icons.apartment, color: AppTheme.adminColor), title: Text(b.$1), subtitle: Text(b.$3), trailing: StatusChip(label: b.$2, color: AppTheme.info)))),
        ]),
      ),
    );
  }
}
