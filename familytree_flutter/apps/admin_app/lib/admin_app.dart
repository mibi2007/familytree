import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'features/navigation/providers/router_provider.dart';

class AdminApp extends ConsumerWidget {
  final String title;
  final Color seedColor;

  const AdminApp({super.key, this.title = 'Family Chat Admin', this.seedColor = Colors.blueGrey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light),
        appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900], foregroundColor: Colors.white, elevation: 0),
      ),
      routerConfig: router,
    );
  }
}
