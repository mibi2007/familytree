import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authController = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom, size: 80, color: Colors.orange),
            const SizedBox(height: 32),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: authController.isLoading 
                  ? null 
                  : () => ref.read(authControllerProvider.notifier).signInWithEmail(
                      emailController.text, 
                      passwordController.text,
                    ),
                child: authController.isLoading 
                  ? const CircularProgressIndicator() 
                  : const Text('Sign In'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: authController.isLoading 
                ? null 
                : () => ref.read(authControllerProvider.notifier).signUpWithEmail(
                    emailController.text, 
                    passwordController.text,
                  ),
              child: const Text('Don\'t have an account? Sign Up'),
            ),
            const Divider(height: 48),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: authController.isLoading 
                  ? null 
                  : () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
