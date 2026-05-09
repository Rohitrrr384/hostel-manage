import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: ResponsivePage(
        child: Column(children: [
          const GradientHeader(title: 'Scan Pass', subtitle: 'Camera scanner integration point for approved leaves and visitor QR passes.', icon: Icons.qr_code_scanner, color: AppTheme.securityColor),
          const SizedBox(height: 18),
          AspectRatio(aspectRatio: 1, child: Card(child: Center(child: Icon(Icons.qr_code_scanner, size: 96, color: AppTheme.securityColor.withOpacity(.65))))),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mock scan verified successfully'))), icon: const Icon(Icons.verified), label: const Text('Run Mock Verification')),
        ]),
      ),
    );
  }
}
