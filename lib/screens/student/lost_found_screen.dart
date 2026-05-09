import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class LostFoundScreen extends StatelessWidget {
  const LostFoundScreen({super.key});

  List<LostFoundItem> get _items => [
        LostFoundItem(id: 'lf1', reportedBy: 'st1', reporterName: 'Arjun Sharma', type: 'lost', title: 'Black wallet', description: 'Contains college ID and library card.', location: 'Mess hall', createdAt: DateTime.now().subtract(const Duration(hours: 3))),
        LostFoundItem(id: 'lf2', reportedBy: 'st5', reporterName: 'Kabir Jain', type: 'found', title: 'Water bottle', description: 'Blue steel bottle left near reading room.', location: 'Block A study area', createdAt: DateTime.now().subtract(const Duration(hours: 8))),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lost & Found'), actions: [IconButton(tooltip: 'Report item', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report dialog can be connected to API'))), icon: const Icon(Icons.add_location_alt_outlined))]),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeader(title: 'Lost & Found', subtitle: 'Report missing items and help return found belongings.', icon: Icons.search, color: AppTheme.warning),
            const SizedBox(height: 16),
            ..._items.map((item) => Card(child: ListTile(leading: Icon(item.type == 'lost' ? Icons.help_outline : Icons.check_circle_outline, color: item.type == 'lost' ? AppTheme.error : AppTheme.success), title: Text(item.title), subtitle: Text('${item.description}\n${item.location} • ${item.reporterName} • ${timeAgo(item.createdAt)}'), isThreeLine: true, trailing: StatusChip(label: item.type, color: item.type == 'lost' ? AppTheme.error : AppTheme.success)))),
          ],
        ),
      ),
    );
  }
}
