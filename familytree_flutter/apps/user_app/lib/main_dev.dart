import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase with Dev Options
  // await Firebase.initializeApp(options: DefaultFirebaseOptionsDev.currentPlatform);
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
