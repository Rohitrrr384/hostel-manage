import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class HostelStudentsScreen extends StatelessWidget {
  const HostelStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = const [
      ('Arjun Sharma', 'CS21B001', 'A-205', 'Present'),
      ('Priya Patel', 'EC22B018', 'B-102', 'On leave'),
      ('Rahul Singh', 'ME20B044', 'C-301', 'Present'),
      ('Nisha Rao', 'IT23B006', 'A-118', 'Present'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Hostel Students')),
      body: ResponsivePage(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Student Directory', subtitle: 'Room-wise student overview and occupancy snapshot.', icon: Icons.groups, color: AppTheme.wardenColor),
          const SizedBox(height: 16),
          ...students.map((s) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(s.$1), subtitle: Text('${s.$2} • Room ${s.$3}'), trailing: StatusChip(label: s.$4, color: s.$4 == 'Present' ? AppTheme.success : AppTheme.warning)))),
        ]),
      ),
    );
  }
}
