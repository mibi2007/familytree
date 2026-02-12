import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';
import '../../../features/settings/view/settings_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom, size: 80, color: Colors.orange),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Watch((context) {
              final isLoading = authSignalsController.isLoadingSignal.value;

              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => authSignalsController.signInWithEmail(_emailController.text, _passwordController.text),
                  child: isLoading ? const CircularProgressIndicator() : const Text('Sign In'),
                ),
              );
            }),
            const SizedBox(height: 16),
            Watch((context) {
              final isLoading = authSignalsController.isLoadingSignal.value;

              return TextButton(
                onPressed: isLoading
                    ? null
                    : () => authSignalsController.signUpWithEmail(_emailController.text, _passwordController.text),
                child: const Text('Don\'t have an account? Sign Up'),
              );
            }),
            const Divider(height: 48),
            Watch((context) {
              final isLoading = authSignalsController.isLoadingSignal.value;

              return SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: isLoading ? null : authSignalsController.signInWithGoogle,
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in with Google'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
