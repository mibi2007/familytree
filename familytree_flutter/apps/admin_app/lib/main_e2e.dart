import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';

const _adminEmail = String.fromEnvironment('E2E_ADMIN_EMAIL');
const _adminPassword = String.fromEnvironment('E2E_ADMIN_PASSWORD');
const _pendingAdminEmail = String.fromEnvironment('E2E_PENDING_ADMIN_EMAIL');
const _pendingAdminPassword = String.fromEnvironment(
  'E2E_PENDING_ADMIN_PASSWORD',
);
const _rejectedAdminEmail = String.fromEnvironment('E2E_REJECTED_ADMIN_EMAIL');
const _rejectedAdminPassword = String.fromEnvironment(
  'E2E_REJECTED_ADMIN_PASSWORD',
);
const _applicantAdminEmail = String.fromEnvironment(
  'E2E_APPLICANT_ADMIN_EMAIL',
);
const _applicantAdminPassword = String.fromEnvironment(
  'E2E_APPLICANT_ADMIN_PASSWORD',
);
const _firebaseOptions = FirebaseOptions(
  apiKey: 'e2e-api-key',
  appId: '1:123456789:web:e2e-admin',
  messagingSenderId: '123456789',
  projectId: 'mibi-family-tree-dev',
  storageBucket: 'mibi-family-tree-dev.appspot.com',
);

void main() async {
  await bootstrap(
    firebaseOptions: _firebaseOptions,
    environment: AppEnvironment.local,
    grpcHost: '127.0.0.1',
    grpcPort: 9090,
    useSecureGrpc: false,
    appTitle: 'Admin App (E2E)',
    beforeRunApp: () async {
      final persona = Uri.base.queryParameters['e2eAuth'];
      final (email, password) = switch (persona) {
        'admin' => (_adminEmail, _adminPassword),
        'pending' => (_pendingAdminEmail, _pendingAdminPassword),
        'rejected' => (_rejectedAdminEmail, _rejectedAdminPassword),
        'applicant' => (_applicantAdminEmail, _applicantAdminPassword),
        _ => ('', ''),
      };
      if (email.isEmpty && password.isEmpty) return;
      if (email.isEmpty || password.isEmpty) {
        throw StateError(
          'E2E credentials for $persona were not provided at build time.',
        );
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    },
  );
}
