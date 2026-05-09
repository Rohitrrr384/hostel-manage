import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class LaundryBookingScreen extends StatefulWidget {
  const LaundryBookingScreen({super.key});

  @override
  State<LaundryBookingScreen> createState() => _LaundryBookingScreenState();
}

class _LaundryBookingScreenState extends State<LaundryBookingScreen> {
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  String _slot = AppConstants.laundrySlots.first;
  double _items = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<LaundryProvider>().fetchSlots());
  }

  Future<void> _book() async {
    final user = context.read<AuthProvider>().user;
    await context.read<LaundryProvider>().bookSlot(LaundrySlot(
          id: 'ls${DateTime.now().millisecondsSinceEpoch}',
          studentId: user?.id ?? 'st1',
          studentName: user?.name ?? 'Student',
          roomNumber: user?.roomNumber ?? 'A-205',
          date: _date,
          timeSlot: _slot,
          itemCount: _items.round(),
          createdAt: DateTime.now(),
        ));
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Laundry slot booked')));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LaundryProvider>();
    final user = context.watch<AuthProvider>().user;
    final booked = provider.getBookedSlots(_date);
    final mine = provider.getStudentSlots(user?.id ?? 'st1');
    return Scaffold(
      appBar: AppBar(title: const Text('Laundry Booking')),
      body: ResponsivePage(
        onRefresh: () => context.read<LaundryProvider>().fetchSlots(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: Text(formatDate(_date)),
              onPressed: () async {
                final picked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 14)), initialDate: _date);
                if (picked != null) setState(() => _date = picked);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _slot,
              decoration: const InputDecoration(labelText: 'Time slot'),
              items: AppConstants.laundrySlots.map((s) => DropdownMenuItem(value: s, enabled: !booked.contains(s), child: Text(booked.contains(s) ? '$s • booked' : s))).toList(),
              onChanged: (value) => value == null ? null : setState(() => _slot = value),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Items: ${_items.round()}', style: Theme.of(context).textTheme.titleLarge),
                  Slider(value: _items, min: 1, max: 25, divisions: 24, label: '${_items.round()}', onChanged: (v) => setState(() => _items = v)),
                ]),
              ),
            ),
            SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: booked.contains(_slot) ? null : _book, icon: const Icon(Icons.local_laundry_service), label: const Text('Book Slot'))),
            const SectionTitle(title: 'My Bookings'),
            if (provider.isLoading)
              const LoadingList(count: 2)
            else if (mine.isEmpty)
              const EmptyState(icon: Icons.local_laundry_service, title: 'No bookings', message: 'Reserve a slot to avoid laundry room crowding.')
            else
              ...mine.map((s) => Card(child: ListTile(leading: const Icon(Icons.local_laundry_service), title: Text('${formatDate(s.date)} • ${s.timeSlot}'), subtitle: Text('${s.itemCount} items'), trailing: StatusChip(label: s.status.name)))),
          ],
        ),
      ),
    );
  }
}
