import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Firebase with Staging Options (Once configured)
  // await Firebase.initializeApp(options: DefaultFirebaseOptionsStg.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Chat (STG)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(body: Center(child: Text('User App - STG'))),
    );
  }
}
