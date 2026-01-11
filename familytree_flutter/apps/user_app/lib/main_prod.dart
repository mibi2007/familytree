import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';
import 'core/config/firebase_options_prod.dart';

void main() async {
  await bootstrap(
    firebaseOptions: DefaultFirebaseOptionsProd.currentPlatform,
    environment: AppEnvironment.prod,
    appTitle: 'Family Chat',
    seedColor: Colors.teal,
  );
}
