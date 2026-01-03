import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase with Production Options (Once configured)
  // await Firebase.initializeApp(options: DefaultFirebaseOptionsProd.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Scaffold(body: Center(child: Text('User App - PROD'))),
    );
  }
}
