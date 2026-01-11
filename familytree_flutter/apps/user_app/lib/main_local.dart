import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'core/config/firebase_options_dev.dart';
import 'features/auth/presentation/login_page.dart';
import 'features/home/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final options = DefaultFirebaseOptionsDev.currentPlatform;
  // Explicitly set databaseURL for emulator to avoid "Cannot parse Firebase url" error on Web
  final devOptions = FirebaseOptions(
    apiKey: options.apiKey,
    appId: options.appId,
    messagingSenderId: options.messagingSenderId,
    projectId: options.projectId,
    authDomain: options.authDomain,
    storageBucket: options.storageBucket,
    measurementId: options.measurementId,
    databaseURL: 'http://127.0.0.1:9000/?ns=${options.projectId}',
  );

  await Firebase.initializeApp(options: devOptions);

  // Connect to Firebase Emulators
  const host = '127.0.0.1';
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  FirebaseDatabase.instance.useDatabaseEmulator(host, 9000);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(environment: AppEnvironment.local, grpcHost: 'localhost', grpcPort: 50051, useSecureGrpc: false),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // Listen to AuthController errors
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString()), backgroundColor: Colors.red));
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Family Chat (LOCAL)',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: authState.when(
        data: (user) => user != null ? const HomePage() : const LoginPage(),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, stack) => Scaffold(body: Center(child: Text('Auth Error: $err'))),
      ),
    );
  }
}
