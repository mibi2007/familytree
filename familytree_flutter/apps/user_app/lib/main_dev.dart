import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';
import 'core/config/firebase_options_dev.dart';

void main() async {
  await bootstrap(
    firebaseOptions: DefaultFirebaseOptionsDev.currentPlatform,
    environment: AppEnvironment.dev,
    appTitle: 'Family Chat (DEV)',
  );
}
