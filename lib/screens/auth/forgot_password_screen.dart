import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: ResponsivePage(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const GradientHeader(
                  title: 'Password help',
                  subtitle: 'Enter your registered email to receive reset instructions.',
                  icon: Icons.mark_email_read_outlined,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Registered email', prefixIcon: Icon(Icons.email_outlined)),
                  validator: (value) => value != null && value.contains('@') ? null : 'Enter a valid email',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.send_outlined),
                    label: const Text('Send reset link'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Reset link sent to ${_email.text.trim()}')),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
