import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase with Staging Options
  runApp(const ProviderScope(child: AdminApp()));
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat Admin (STG)',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const Scaffold(body: Center(child: Text('Admin App - STG'))),
    );
  }
}
