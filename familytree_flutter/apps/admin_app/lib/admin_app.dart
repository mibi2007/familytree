import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'features/navigation/providers/router_signals.dart';

class AdminApp extends StatelessWidget {
  final String title;
  final Color seedColor;

  const AdminApp({super.key, this.title = 'Family Chat Admin', this.seedColor = Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final themeMode = toFlutterThemeMode(themeModeSignal.value);

      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: themeMode,
        routerConfig: router,
      );
    });
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light),
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900], foregroundColor: Colors.white, elevation: 0),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
      appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900], foregroundColor: Colors.white, elevation: 0),
    );
  }
}
