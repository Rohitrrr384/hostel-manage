import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../widgets/app_widgets.dart';

class VisitorRequestScreen extends StatefulWidget {
  const VisitorRequestScreen({super.key});

  @override
  State<VisitorRequestScreen> createState() => _VisitorRequestScreenState();
}

class _VisitorRequestScreenState extends State<VisitorRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _relation = TextEditingController();
  final _purpose = TextEditingController();
  double _count = 1;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _relation.dispose();
    _purpose.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final user = context.read<AuthProvider>().user;
    await context.read<VisitorProvider>().registerVisitor(Visitor(
          id: 'v${DateTime.now().millisecondsSinceEpoch}',
          studentId: user?.id ?? 'st1',
          studentName: user?.name ?? 'Student',
          roomNumber: user?.roomNumber ?? 'A-205',
          visitorName: _name.text.trim(),
          visitorPhone: _phone.text.trim(),
          relationship: _relation.text.trim(),
          purpose: _purpose.text.trim(),
          numberOfVisitors: _count.round(),
          createdAt: DateTime.now(),
        ));
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Visitor request created')));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VisitorProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Visitor Request')),
      body: ResponsivePage(
        onRefresh: () => context.read<VisitorProvider>().fetchVisitors(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Visitor name'), validator: (v) => v != null && v.trim().isNotEmpty ? null : 'Required'),
              const SizedBox(height: 12),
              TextFormField(controller: _phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone number'), validator: (v) => v != null && v.trim().length >= 10 ? null : 'Enter valid phone'),
              const SizedBox(height: 12),
              TextFormField(controller: _relation, decoration: const InputDecoration(labelText: 'Relationship'), validator: (v) => v != null && v.trim().isNotEmpty ? null : 'Required'),
              const SizedBox(height: 12),
              TextFormField(controller: _purpose, decoration: const InputDecoration(labelText: 'Purpose'), validator: (v) => v != null && v.trim().isNotEmpty ? null : 'Required'),
              const SizedBox(height: 12),
              Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Visitors: ${_count.round()}'), Slider(value: _count, min: 1, max: 5, divisions: 4, onChanged: (v) => setState(() => _count = v))]))),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _register, icon: const Icon(Icons.badge), label: const Text('Request Visitor Pass'))),
              const SectionTitle(title: 'Recent Visitors'),
              ...provider.visitors.map((v) => Card(child: ListTile(leading: const Icon(Icons.person_pin_circle), title: Text(v.visitorName), subtitle: Text('${v.relationship} • ${v.purpose}'), trailing: StatusChip(label: v.status.name)))),
            ],
          ),
        ),
      ),
    );
  }
}
