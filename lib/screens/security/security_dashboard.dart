import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({super.key});

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}

class _SecurityDashboardState extends State<SecurityDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<VisitorProvider>().fetchVisitors());
  }

  @override
  Widget build(BuildContext context) {
    final visitors = context.watch<VisitorProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Security Dashboard')),
      drawer: const AppDrawer(role: 'security', destinations: [
        DrawerDestination('Dashboard', '/security', Icons.dashboard),
        DrawerDestination('Visitor Verification', '/security/visitors', Icons.verified_user),
        DrawerDestination('Gate Logs', '/security/logs', Icons.receipt_long),
        DrawerDestination('QR Scanner', '/security/qr', Icons.qr_code_scanner),
      ]),
      body: ResponsivePage(
        onRefresh: () => context.read<VisitorProvider>().fetchVisitors(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GradientHeader(title: 'Gate Control', subtitle: 'Verify visitors, track entries and process exits.', icon: Icons.security, color: AppTheme.securityColor),
          const SizedBox(height: 16),
          AdaptiveGrid(children: [
            StatCard(title: 'Active Visitors', value: '${visitors.activeVisitors.length}', icon: Icons.people, color: AppTheme.securityColor),
            StatCard(title: 'Pending Requests', value: '${visitors.visitors.where((v) => v.status.name == 'pending').length}', icon: Icons.pending_actions, color: AppTheme.warning),
            const StatCard(title: 'Today Entries', value: '36', icon: Icons.login, color: AppTheme.info),
            const StatCard(title: 'Alerts', value: '0', icon: Icons.warning_amber, color: AppTheme.success),
          ]),
          const SectionTitle(title: 'Security Actions'),
          AdaptiveGrid(minTileWidth: 320, childAspectRatio: 2.6, children: [
            FeatureTile(title: 'Verify Visitors', subtitle: 'Approve entry and record exits', icon: Icons.verified, color: AppTheme.securityColor, onTap: () => Navigator.pushNamed(context, '/security/visitors')),
            FeatureTile(title: 'Scan QR', subtitle: 'Validate approved leave or visitor pass', icon: Icons.qr_code_scanner, color: AppTheme.info, onTap: () => Navigator.pushNamed(context, '/security/qr')),
            FeatureTile(title: 'Gate Logs', subtitle: 'Search movement history', icon: Icons.receipt_long, color: AppTheme.warning, onTap: () => Navigator.pushNamed(context, '/security/logs')),
          ]),
        ]),
      ),
    );
  }
}
