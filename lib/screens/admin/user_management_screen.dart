import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import '../../widgets/app_widgets.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _studentId = TextEditingController();
  final _roomNumber = TextEditingController();
  final _block = TextEditingController(text: 'A');
  final _hostelName = TextEditingController(text: 'Boys Hostel A');
  final _assignment = TextEditingController();

  String _role = 'student';
  bool _isActive = true;

  final List<_RegisteredUser> _users = [
    _RegisteredUser('Arjun Sharma', 'student@hostelsync.app', 'student', 'A-205', true),
    _RegisteredUser('Dr. Ramesh Kumar', 'warden@hostelsync.app', 'warden', 'Boys Hostel A', true),
    _RegisteredUser('Shyam Singh', 'security@hostelsync.app', 'security', 'Main Gate', true),
    _RegisteredUser('Suresh Babu', 'mess@hostelsync.app', 'mess', 'Central Mess', true),
    _RegisteredUser('Principal Admin', 'admin@hostelsync.app', 'admin', 'System Admin', true),
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _studentId.dispose();
    _roomNumber.dispose();
    _block.dispose();
    _hostelName.dispose();
    _assignment.dispose();
    super.dispose();
  }

  bool get _isStudent => _role == 'student';
  bool get _needsHostel => _role == 'student' || _role == 'warden';

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    final displayLocation = _isStudent
        ? _roomNumber.text.trim()
        : _needsHostel
            ? _hostelName.text.trim()
            : _assignment.text.trim();
    final generatedPassword = _password.text.trim().isEmpty
        ? (_isStudent && _studentId.text.trim().isNotEmpty ? '${_studentId.text.trim()}@123' : 'password')
        : _password.text.trim();

    setState(() {
      _users.insert(
        0,
        _RegisteredUser(
          _name.text.trim(),
          _email.text.trim(),
          _role,
          displayLocation,
          _isActive,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_name.text.trim()} registered. Temporary password: $generatedPassword')),
    );

    _formKey.currentState!.reset();
    _name.clear();
    _email.clear();
    _phone.clear();
    _password.clear();
    _studentId.clear();
    _roomNumber.clear();
    _assignment.clear();
    _block.text = 'A';
    _hostelName.text = 'Boys Hostel A';
    setState(() {
      _role = 'student';
      _isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().user;
    if (currentUser?.role != 'admin') {
      return Scaffold(
        appBar: AppBar(title: const Text('User Management')),
        body: const ResponsivePage(
          child: EmptyState(
            icon: Icons.admin_panel_settings,
            title: 'Admin access required',
            message: 'Only admins can register users and assign roles.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeader(
              title: 'Register Users',
              subtitle: 'Create accounts for students, wardens, security, mess staff and admins.',
              icon: Icons.manage_accounts,
              color: AppTheme.adminColor,
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 900;
                final form = _RegistrationForm(
                  formKey: _formKey,
                  role: _role,
                  isStudent: _isStudent,
                  needsHostel: _needsHostel,
                  isActive: _isActive,
                  name: _name,
                  email: _email,
                  phone: _phone,
                  password: _password,
                  studentId: _studentId,
                  roomNumber: _roomNumber,
                  block: _block,
                  hostelName: _hostelName,
                  assignment: _assignment,
                  onRoleChanged: (value) => setState(() => _role = value),
                  onActiveChanged: (value) => setState(() => _isActive = value),
                  onSubmit: _register,
                );
                final list = _UserDirectory(
                  users: _users,
                  onToggle: (index, value) => setState(() => _users[index].isActive = value),
                );

                if (!wide) {
                  return Column(children: [form, const SizedBox(height: 16), list]);
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: form),
                    const SizedBox(width: 16),
                    Expanded(flex: 4, child: list),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String role;
  final bool isStudent;
  final bool needsHostel;
  final bool isActive;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController studentId;
  final TextEditingController roomNumber;
  final TextEditingController block;
  final TextEditingController hostelName;
  final TextEditingController assignment;
  final ValueChanged<String> onRoleChanged;
  final ValueChanged<bool> onActiveChanged;
  final VoidCallback onSubmit;

  const _RegistrationForm({
    required this.formKey,
    required this.role,
    required this.isStudent,
    required this.needsHostel,
    required this.isActive,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.studentId,
    required this.roomNumber,
    required this.block,
    required this.hostelName,
    required this.assignment,
    required this.onRoleChanged,
    required this.onActiveChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account Details', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: role,
                decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.badge_outlined)),
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'warden', child: Text('Warden')),
                  DropdownMenuItem(value: 'security', child: Text('Security')),
                  DropdownMenuItem(value: 'mess', child: Text('Mess Staff')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) => value == null ? null : onRoleChanged(value),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full name', prefixIcon: Icon(Icons.person_outline)),
                validator: _required,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone_outlined)),
                validator: (value) => value != null && value.trim().length >= 10 ? null : 'Enter valid phone number',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Temporary password',
                  hintText: 'Leave empty to auto-generate',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              if (isStudent) ...[
                const SizedBox(height: 16),
                Text('Student Allocation', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                TextFormField(
                  controller: studentId,
                  decoration: const InputDecoration(labelText: 'Student ID', prefixIcon: Icon(Icons.confirmation_number_outlined)),
                  validator: _required,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: roomNumber,
                  decoration: const InputDecoration(labelText: 'Room number', prefixIcon: Icon(Icons.meeting_room_outlined)),
                  validator: _required,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: block,
                  decoration: const InputDecoration(labelText: 'Block', prefixIcon: Icon(Icons.apartment_outlined)),
                  validator: _required,
                ),
              ],
              if (needsHostel) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: hostelName,
                  decoration: const InputDecoration(labelText: 'Hostel name', prefixIcon: Icon(Icons.business_outlined)),
                  validator: _required,
                ),
              ],
              if (!needsHostel) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: assignment,
                  decoration: InputDecoration(
                    labelText: role == 'security'
                        ? 'Gate / shift assignment'
                        : role == 'mess'
                            ? 'Mess assignment'
                            : 'Admin scope',
                    prefixIcon: const Icon(Icons.work_outline),
                  ),
                  validator: _required,
                ),
              ],
              const SizedBox(height: 10),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: isActive,
                onChanged: onActiveChanged,
                title: const Text('Account active'),
                subtitle: const Text('Inactive users cannot sign in.'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Register User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String? _required(String? value) => value != null && value.trim().isNotEmpty ? null : 'Required';
}

class _UserDirectory extends StatelessWidget {
  final List<_RegisteredUser> users;
  final void Function(int index, bool value) onToggle;

  const _UserDirectory({required this.users, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Registered Users', style: Theme.of(context).textTheme.headlineSmall),
            ),
            ...users.asMap().entries.map((entry) {
              final index = entry.key;
              final user = entry.value;
              final color = getRoleColor(user.role);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withOpacity(.14),
                  child: Icon(_roleIcon(user.role), color: color),
                ),
                title: Text(user.name),
                subtitle: Text('${_roleLabel(user.role)} - ${user.email}\n${user.location}'),
                isThreeLine: true,
                trailing: Switch(
                  value: user.isActive,
                  onChanged: (value) => onToggle(index, value),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  IconData _roleIcon(String role) {
    switch (role) {
      case 'student':
        return Icons.school_outlined;
      case 'warden':
        return Icons.supervisor_account_outlined;
      case 'security':
        return Icons.security_outlined;
      case 'mess':
        return Icons.restaurant_outlined;
      case 'admin':
        return Icons.admin_panel_settings_outlined;
      default:
        return Icons.person_outline;
    }
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'mess':
        return 'Mess Staff';
      default:
        return '${role[0].toUpperCase()}${role.substring(1)}';
    }
  }
}

class _RegisteredUser {
  final String name;
  final String email;
  final String role;
  final String location;
  bool isActive;

  _RegisteredUser(this.name, this.email, this.role, this.location, this.isActive);
}
