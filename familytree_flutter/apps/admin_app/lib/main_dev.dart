import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptionsDev.currentPlatform,
  );
  runApp(const ProviderScope(child: AdminApp()));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat Admin (DEV)',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const Scaffold(body: Center(child: Text('Admin App - DEV'))),
    );
  }
}
