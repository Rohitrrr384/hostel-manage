import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  List<MarketplaceItem> get _items => [
        MarketplaceItem(id: 'm1', sellerId: 'st2', sellerName: 'Priya Patel', roomNumber: 'B-102', title: 'Engineering Graphics Kit', description: 'Mini drafter, set squares and sheets in good condition.', price: 650, category: MarketplaceCategory.books, createdAt: DateTime.now().subtract(const Duration(hours: 4))),
        MarketplaceItem(id: 'm2', sellerId: 'st3', sellerName: 'Rahul Singh', roomNumber: 'C-301', title: 'Study Table Lamp', description: 'Adjustable LED lamp with warm and cool modes.', price: 450, category: MarketplaceCategory.electronics, createdAt: DateTime.now().subtract(const Duration(days: 1))),
        MarketplaceItem(id: 'm3', sellerId: 'st4', sellerName: 'Nisha Rao', roomNumber: 'A-118', title: 'Single Mattress', description: 'Clean mattress, used for one semester only.', price: 1200, category: MarketplaceCategory.furniture, createdAt: DateTime.now().subtract(const Duration(days: 2))),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace'), actions: [IconButton(tooltip: 'Add listing', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listing form ready for backend integration'))), icon: const Icon(Icons.add))]),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeader(title: 'Hostel Marketplace', subtitle: 'Trusted listings from students in your hostel.', icon: Icons.storefront, color: AppTheme.info),
            const SizedBox(height: 16),
            AdaptiveGrid(
              minTileWidth: 300,
              childAspectRatio: 1.35,
              children: _items
                  .map((item) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [const Icon(Icons.inventory_2_outlined), const Spacer(), StatusChip(label: item.category.name, color: AppTheme.info)]),
                            const SizedBox(height: 12),
                            Text(item.title, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 6),
                            Expanded(child: Text(item.description, style: Theme.of(context).textTheme.bodyMedium)),
                            Text('Rs. ${item.price.toStringAsFixed(0)}', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.info)),
                            Text('${item.sellerName} • ${item.roomNumber} • ${timeAgo(item.createdAt)}', style: Theme.of(context).textTheme.bodySmall),
                          ]),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
