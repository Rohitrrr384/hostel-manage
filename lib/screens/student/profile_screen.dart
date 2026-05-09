import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class ProfileScreen extends StatelessWidget {
  final bool showAppBar;
  const ProfileScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('Profile')) : null,
      body: ResponsivePage(
        child: Column(
          children: [
            GradientHeader(
              title: user?.name ?? 'Student',
              subtitle: '${user?.studentId ?? 'CS21B001'} • ${user?.roomNumber ?? 'A-205'}',
              icon: Icons.person,
              color: AppTheme.studentColor,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _row(Icons.mail_outline, 'Email', user?.email ?? '-'),
                  _row(Icons.phone_outlined, 'Phone', user?.phone ?? '-'),
                  _row(Icons.apartment_outlined, 'Hostel', user?.hostelName ?? '-'),
                  _row(Icons.meeting_room_outlined, 'Block', user?.block ?? '-'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () async {
                  await context.read<AuthProvider>().logout();
                  if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) => ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: Text(value),
      );
}
