import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_options_prod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptionsProd.currentPlatform,
  );
  runApp(const ProviderScope(child: AdminApp()));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat Admin',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const Scaffold(body: Center(child: Text('Admin App - PROD'))),
    );
  }
}
