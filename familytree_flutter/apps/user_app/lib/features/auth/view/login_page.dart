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
            tooltip: l10n.settings,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.family_restroom,
                  size: 80,
                  color: Colors.orange,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: null,
                    border: OutlineInputBorder(),
                  ).copyWith(labelText: l10n.email),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: null,
                    border: OutlineInputBorder(),
                  ).copyWith(labelText: l10n.password),
                  obscureText: true,
                ),
                Watch((context) {
                  final error = authSignalsController.errorSignal.value;
                  if (error == null) return const SizedBox.shrink();

                  return Semantics(
                    liveRegion: true,
                    label: l10n.authenticationError(error),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        l10n.authenticationError(error),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Watch((context) {
                  final isLoading = authSignalsController.isLoadingSignal.value;

                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => authSignalsController.signInWithEmail(
                              _emailController.text,
                              _passwordController.text,
                            ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text(l10n.signIn),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Watch((context) {
                  final isLoading = authSignalsController.isLoadingSignal.value;

                  return TextButton(
                    onPressed: isLoading
                        ? null
                        : () => authSignalsController.signUpWithEmail(
                            _emailController.text,
                            _passwordController.text,
                          ),
                    child: Text(l10n.signUpPrompt),
                  );
                }),
                const Divider(height: 48),
                Watch((context) {
                  final isLoading = authSignalsController.isLoadingSignal.value;

                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: isLoading
                          ? null
                          : authSignalsController.signInWithGoogle,
                      icon: const Icon(Icons.login),
                      label: Text(l10n.signInWithGoogle),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
