import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'admin_app.dart';

Future<void> bootstrap({
  required FirebaseOptions firebaseOptions,
  AppEnvironment environment = AppEnvironment.prod,
  String grpcHost = '127.0.0.1',
  int grpcPort = 50051,
  bool useSecureGrpc = true,
  String appTitle = 'Family Chat Admin',
  Color seedColor = Colors.blueGrey,
  bool initFirebase = true,
}) async {
  await sharedBootstrap(
    firebaseOptions: firebaseOptions,
    environment: environment,
    grpcHost: grpcHost,
    grpcPort: grpcPort,
    useSecureGrpc: useSecureGrpc,
    initFirebase: initFirebase,
    builder: (config) => AdminApp(title: appTitle, seedColor: seedColor),
  );
}
