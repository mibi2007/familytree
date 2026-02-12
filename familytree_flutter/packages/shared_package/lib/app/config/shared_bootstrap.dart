import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

Future<void> sharedBootstrap({
  required FirebaseOptions firebaseOptions,
  required Widget Function(AppConfig) builder,
  AppEnvironment environment = AppEnvironment.prod,
  String grpcHost = '127.0.0.1',
  int grpcPort = 50051,
  bool useSecureGrpc = true,
  bool initFirebase = true,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase Initialization
  if (initFirebase) {
    if (environment == AppEnvironment.local) {
      // Local Emulator Setup
      final localOptions = FirebaseOptions(
        apiKey: firebaseOptions.apiKey,
        appId: firebaseOptions.appId,
        messagingSenderId: firebaseOptions.messagingSenderId,
        projectId: firebaseOptions.projectId,
        authDomain: '127.0.0.1:9099',
        storageBucket: firebaseOptions.storageBucket,
        measurementId: firebaseOptions.measurementId,
        databaseURL: 'http://127.0.0.1:9000/?ns=${firebaseOptions.projectId}',
      );

      try {
        await Firebase.initializeApp(options: localOptions);

        const host = '127.0.0.1';
        await FirebaseAuth.instance.useAuthEmulator(host, 9099);
        FirebaseDatabase.instance.useDatabaseEmulator(host, 9000);
        await FirebaseStorage.instance.useStorageEmulator(host, 9199);
      } catch (e) {
        debugPrint('Firebase init error (ignored for mocks/re-init): $e');
      }
    } else {
      // Real Firebase Setup
      try {
        await Firebase.initializeApp(options: firebaseOptions);
      } catch (e) {
        debugPrint('Firebase init error: $e');
      }
    }
  }

  // 2. gRPC & Infrastructure Initialization
  final appConfig = AppConfig(
    environment: environment,
    grpcHost: grpcHost,
    grpcPort: grpcPort,
    useSecureGrpc: useSecureGrpc,
  );

  initGrpcChannel(appConfig);

  // 3. Settings & Auth Signals Initialization
  await initSettings();

  if (initFirebase) {
    initAuthRepository();
  }

  // 4. Global Auth State Listener
  // Syncs settings when user logs in/out
  authUserSignal.subscribe((authState) {
    authState.map(
      data: (user) {
        if (user != null) {
          syncSettingsFromBackend(user.uid);
        }
      },
      loading: () {},
      error: (_, __) {},
    );
  });

  // 5. Run App
  runApp(ProviderScope(overrides: [appConfigProvider.overrideWithValue(appConfig)], child: builder(appConfig)));
}
