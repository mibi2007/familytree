import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'core/config/firebase_options_dev.dart';

import 'features/auth/presentation/admin_login_page.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptionsDev.currentPlatform,
  );

  // Connect to Firebase Emulators
  const host = 'localhost';
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  FirebaseDatabase.instance.useDatabaseEmulator(host, 9000);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(
            environment: AppEnvironment.local,
            grpcHost: 'localhost',
            grpcPort: 50051,
            useSecureGrpc: false,
          ),
        ),
      ],
      child: const AdminApp(),
    ),
  );
}

class AdminApp extends ConsumerWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // Listen to AuthController errors
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return MaterialApp(
      title: 'Admin App (LOCAL)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: authState.when(
        data: (user) => user != null ? const AdminDashboardPage() : const AdminLoginPage(),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) => Scaffold(body: Center(child: Text('Auth Error: $err'))),
      ),
    );
  }
}
