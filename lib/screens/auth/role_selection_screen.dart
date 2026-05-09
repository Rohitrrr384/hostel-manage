import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Future<void> _enter(BuildContext context, String role) async {
    await context.read<AuthProvider>().login('$role@hostelsync.app', 'password');
    if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/$role', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final roles = [
      ('Student', 'Daily services, requests, notices', 'student', Icons.school, AppTheme.studentColor),
      ('Warden', 'Approvals and hostel operations', 'warden', Icons.supervisor_account, AppTheme.wardenColor),
      ('Security', 'Visitors, gate logs, QR checks', 'security', Icons.security, AppTheme.securityColor),
      ('Mess Staff', 'Menus, attendance, feedback', 'mess', Icons.restaurant, AppTheme.messColor),
      ('Admin', 'Users, analytics, hostels', 'admin', Icons.admin_panel_settings, AppTheme.adminColor),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Select Demo Role')),
      body: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GradientHeader(
              title: 'Pick your workspace',
              subtitle: 'Each role opens a tailored production-style dashboard.',
              icon: Icons.dashboard_customize,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 18),
            AdaptiveGrid(
              childAspectRatio: 1.35,
              children: roles
                  .map(
                    (r) => FeatureTile(
                      title: r.$1,
                      subtitle: r.$2,
                      icon: r.$4,
                      color: r.$5,
                      onTap: () => _enter(context, r.$3),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
