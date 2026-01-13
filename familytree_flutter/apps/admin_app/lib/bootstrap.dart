import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'admin_app.dart';

Future<void> bootstrap({
  required FirebaseOptions firebaseOptions,
  AppEnvironment environment = AppEnvironment.prod,
  String grpcHost = 'localhost',
  int grpcPort = 50051,
  bool useSecureGrpc = true,
  String appTitle = 'Family Chat Admin',
  Color seedColor = Colors.blueGrey,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (environment == AppEnvironment.local) {
    // When running locally, we need to override the databaseURL to point to the emulator
    // so that Firebase.initializeApp doesn't fail or complain about missing URL.
    // We create a new FirebaseOptions instance with the emulator URL.
    final localOptions = FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId,
      authDomain: firebaseOptions.authDomain,
      storageBucket: firebaseOptions.storageBucket,
      measurementId: firebaseOptions.measurementId,
      // databaseURL: 'http://127.0.0.1:9000/?ns=${firebaseOptions.projectId}',
    );

    await Firebase.initializeApp(options: localOptions);

    // Connect to Firebase Emulators
    // const host = '127.0.0.1';
    // await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    // FirebaseDatabase.instance.useDatabaseEmulator(host, 9000);
    // await FirebaseStorage.instance.useStorageEmulator(host, 9199);
  } else {
    await Firebase.initializeApp(options: firebaseOptions);
  }

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          AppConfig(environment: environment, grpcHost: grpcHost, grpcPort: grpcPort, useSecureGrpc: useSecureGrpc),
        ),
      ],
      child: AdminApp(title: appTitle, seedColor: seedColor),
    ),
  );
}
