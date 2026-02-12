import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'user_app.dart';

Future<void> bootstrap({
  required FirebaseOptions firebaseOptions,
  AppEnvironment environment = AppEnvironment.prod,
  String grpcHost = '127.0.0.1',
  int grpcPort = 50051,
  bool useSecureGrpc = true,
  String appTitle = 'Family Chat',
  Color seedColor = Colors.deepPurple,
  bool initFirebase = true,
}) async {
  await sharedBootstrap(
    firebaseOptions: firebaseOptions,
    environment: environment,
    grpcHost: grpcHost,
    grpcPort: grpcPort,
    useSecureGrpc: useSecureGrpc,
    initFirebase: initFirebase,
    builder: (config) => UserApp(title: appTitle, seedColor: seedColor),
  );
}
