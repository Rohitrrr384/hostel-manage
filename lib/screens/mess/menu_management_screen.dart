import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<MessProvider>().fetchMenu());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MessProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Management'), actions: [IconButton(tooltip: 'Edit menu', icon: const Icon(Icons.edit), onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu editor ready for API integration'))))]),
      body: ResponsivePage(
        onRefresh: () => context.read<MessProvider>().fetchMenu(),
        child: provider.isLoading ? const LoadingList() : Column(children: provider.menus.map((m) => Card(child: ListTile(leading: const Icon(Icons.restaurant_menu), title: Text(formatDate(m.date)), subtitle: Text('Breakfast: ${m.breakfast}\nLunch: ${m.lunch}\nDinner: ${m.dinner}'), isThreeLine: true, trailing: const Icon(Icons.edit_outlined)))).toList()),
      ),
    );
  }
}
