import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class LeaveRequestScreen extends StatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reason = TextEditingController();
  final _parent = TextEditingController();
  final _contact = TextEditingController();
  LeaveType _type = LeaveType.home;
  DateTime _departure = DateTime.now().add(const Duration(days: 1));
  DateTime _return = DateTime.now().add(const Duration(days: 3));

  @override
  void dispose() {
    _reason.dispose();
    _parent.dispose();
    _contact.dispose();
    super.dispose();
  }

  Future<void> _pick(bool departure) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: departure ? _departure : _return,
    );
    if (picked != null) setState(() => departure ? _departure = picked : _return = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_return.isBefore(_departure)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Return date must be after departure date')));
      return;
    }
    final user = context.read<AuthProvider>().user;
    final request = LeaveRequest(
      id: 'lr${DateTime.now().millisecondsSinceEpoch}',
      studentId: user?.id ?? 'st1',
      studentName: user?.name ?? 'Student',
      roomNumber: user?.roomNumber ?? 'A-205',
      type: _type,
      reason: _reason.text.trim(),
      departureDate: _departure,
      returnDate: _return,
      parentName: _parent.text.trim(),
      parentContact: _contact.text.trim(),
      createdAt: DateTime.now(),
    );
    await context.read<LeaveProvider>().submitLeaveRequest(request);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Leave request submitted')));
    Navigator.pushReplacementNamed(context, '/student/leave-history');
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<LeaveProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(title: const Text('Apply Leave')),
      body: ResponsivePage(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<LeaveType>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Leave type', prefixIcon: Icon(Icons.category_outlined)),
                items: LeaveType.values.map((t) => DropdownMenuItem(value: t, child: Text(AppConstants.leaveTypeNames[t]!))).toList(),
                onChanged: (value) => setState(() => _type = value!),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () => _pick(true), icon: const Icon(Icons.calendar_month), label: Text('Depart ${formatDate(_departure)}'))),
                  const SizedBox(width: 10),
                  Expanded(child: OutlinedButton.icon(onPressed: () => _pick(false), icon: const Icon(Icons.event_available), label: Text('Return ${formatDate(_return)}'))),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(controller: _reason, maxLines: 4, decoration: const InputDecoration(labelText: 'Reason', alignLabelWithHint: true), validator: (v) => v != null && v.trim().length > 8 ? null : 'Write a clear reason'),
              const SizedBox(height: 12),
              TextFormField(controller: _parent, decoration: const InputDecoration(labelText: 'Parent / guardian name'), validator: (v) => v != null && v.trim().isNotEmpty ? null : 'Required'),
              const SizedBox(height: 12),
              TextFormField(controller: _contact, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Parent contact'), validator: (v) => v != null && v.trim().length >= 10 ? null : 'Enter valid contact'),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: loading ? null : _submit, icon: const Icon(Icons.send), label: Text(loading ? 'Submitting...' : 'Submit Request'))),
            ],
          ),
        ),
      ),
    );
  }
}
