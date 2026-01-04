import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/config/firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptionsDev.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat (DEV)',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const Scaffold(body: Center(child: Text('User App - DEV'))),
    );
  }
}
