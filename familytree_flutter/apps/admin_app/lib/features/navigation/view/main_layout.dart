import 'package:flutter/material.dart';

import 'widgets/sidebar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: isDesktop ? null : const Sidebar(),
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('Family Tree Admin'),
              backgroundColor: Colors.blueGrey[900],
              foregroundColor: Colors.white,
            ),
      body: Row(
        children: [
          if (isDesktop) const Sidebar(),
          Expanded(
            child: Container(color: Theme.of(context).colorScheme.surface, child: child),
          ),
        ],
      ),
    );
  }
}
