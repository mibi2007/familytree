import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';
import 'core/config/firebase_options_dev.dart';

void main() async {
  await bootstrap(
    firebaseOptions: DefaultFirebaseOptionsDev.currentPlatform,
    environment: AppEnvironment.dev,
    grpcHost: '35.197.150.183.nip.io',
    grpcPort: 443,
    useSecureGrpc: true,
    appTitle: 'Family Chat (DEV)',
  );
}
