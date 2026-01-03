import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase with Production Options
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
