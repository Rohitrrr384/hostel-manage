import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class NoticesManagementScreen extends StatelessWidget {
  const NoticesManagementScreen({super.key});

  void _add(BuildContext context) {
    final title = TextEditingController();
    final content = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Publish Notice'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
          const SizedBox(height: 10),
          TextField(controller: content, maxLines: 3, decoration: const InputDecoration(labelText: 'Content')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () {
            context.read<NoticeProvider>().addNotice(Notice(id: 'n${DateTime.now().millisecondsSinceEpoch}', title: title.text, content: content.text, category: NoticeCategory.important, postedBy: 'Warden', isPinned: true, createdAt: DateTime.now()));
            Navigator.pop(context);
          }, child: const Text('Publish')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Notice Management'), actions: [IconButton(tooltip: 'Add notice', icon: const Icon(Icons.add), onPressed: () => _add(context))]),
      body: ResponsivePage(
        onRefresh: () => context.read<NoticeProvider>().fetchNotices(),
        child: Column(children: provider.notices.map((n) => Card(child: ListTile(leading: Icon(getNoticeCategoryIcon(n.category), color: getNoticeCategoryColor(n.category)), title: Text(n.title), subtitle: Text(n.content), trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => context.read<NoticeProvider>().deleteNotice(n.id))))).toList()),
      ),
    );
  }
}
