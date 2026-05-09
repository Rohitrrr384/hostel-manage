import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  ComplaintCategory _category = ComplaintCategory.water;
  ComplaintPriority _priority = ComplaintPriority.medium;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = context.read<AuthProvider>().user;
    final complaint = Complaint(
      id: 'c${DateTime.now().millisecondsSinceEpoch}',
      studentId: user?.id ?? 'st1',
      studentName: user?.name ?? 'Student',
      roomNumber: user?.roomNumber ?? 'A-205',
      category: _category,
      title: _title.text.trim(),
      description: _description.text.trim(),
      priority: _priority,
      createdAt: DateTime.now(),
    );
    await context.read<ComplaintProvider>().submitComplaint(complaint);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complaint raised successfully')));
    Navigator.pushReplacementNamed(context, '/student/complaint-history');
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<ComplaintProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(title: const Text('Raise Complaint')),
      body: ResponsivePage(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<ComplaintCategory>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category', prefixIcon: Icon(Icons.category)),
                items: ComplaintCategory.values.map((c) => DropdownMenuItem(value: c, child: Text(AppConstants.complaintCategoryNames[c]!))).toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ComplaintPriority>(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Priority', prefixIcon: Icon(Icons.flag_outlined)),
                items: ComplaintPriority.values.map((p) => DropdownMenuItem(value: p, child: Text(p.name.toUpperCase()))).toList(),
                onChanged: (value) => setState(() => _priority = value!),
              ),
              const SizedBox(height: 12),
              TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v != null && v.trim().length > 3 ? null : 'Title is required'),
              const SizedBox(height: 12),
              TextFormField(controller: _description, maxLines: 5, decoration: const InputDecoration(labelText: 'Description', alignLabelWithHint: true), validator: (v) => v != null && v.trim().length > 10 ? null : 'Describe the issue clearly'),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: loading ? null : _submit, icon: const Icon(Icons.report), label: Text(loading ? 'Submitting...' : 'Submit Complaint'))),
            ],
          ),
        ),
      ),
    );
  }
}
