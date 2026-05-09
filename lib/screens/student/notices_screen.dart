import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class NoticesScreen extends StatefulWidget {
  final bool showAppBar;
  const NoticesScreen({super.key, this.showAppBar = true});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<NoticeProvider>().fetchNotices());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeProvider>();
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(title: const Text('Notices')) : null,
      body: ResponsivePage(
        onRefresh: () => context.read<NoticeProvider>().fetchNotices(),
        child: provider.isLoading
            ? const LoadingList()
            : provider.notices.isEmpty
                ? const EmptyState(icon: Icons.campaign, title: 'No notices', message: 'Important hostel announcements will appear here.')
                : Column(
                    children: provider.notices
                        .map((n) => Card(
                              child: ListTile(
                                leading: Icon(getNoticeCategoryIcon(n.category), color: getNoticeCategoryColor(n.category)),
                                title: Row(children: [Expanded(child: Text(n.title)), if (n.isPinned) const Icon(Icons.push_pin, size: 18)]),
                                subtitle: Text('${n.content}\n${n.postedBy} • ${timeAgo(n.createdAt)}'),
                                isThreeLine: true,
                              ),
                            ))
                        .toList(),
                  ),
      ),
    );
  }
}
