import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bars = const [('A', .94), ('B', .88), ('C', .91), ('D', .76), ('E', .69)];
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: ResponsivePage(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Hostel Analytics', subtitle: 'Occupancy, service load and operational indicators.', icon: Icons.analytics, color: AppTheme.adminColor),
          const SizedBox(height: 16),
          const AdaptiveGrid(children: [
            StatCard(title: 'Complaints Resolved', value: '86%', icon: Icons.task_alt, color: AppTheme.success),
            StatCard(title: 'Avg Leave Approval', value: '3h', icon: Icons.timer, color: AppTheme.info),
            StatCard(title: 'Mess Rating', value: '4.2', icon: Icons.star, color: AppTheme.warning),
            StatCard(title: 'Visitors Today', value: '36', icon: Icons.badge, color: AppTheme.adminColor),
          ]),
          const SectionTitle(title: 'Block Occupancy'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: bars.map((b) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [SizedBox(width: 28, child: Text(b.$1)), Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: b.$2, minHeight: 10))), const SizedBox(width: 12), Text('${(b.$2 * 100).round()}%')]))).toList()),
            ),
          ),
        ]),
      ),
    );
  }
}
