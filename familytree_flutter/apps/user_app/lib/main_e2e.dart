import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';

const _firebaseOptions = FirebaseOptions(
  apiKey: 'e2e-api-key',
  appId: '1:123456789:web:e2e-user',
  messagingSenderId: '123456789',
  projectId: 'mibi-family-tree-dev',
  storageBucket: 'mibi-family-tree-dev.appspot.com',
);
const _ownerEmail = String.fromEnvironment('E2E_OWNER_EMAIL');
const _ownerPassword = String.fromEnvironment('E2E_OWNER_PASSWORD');
const _memberEmail = String.fromEnvironment('E2E_MEMBER_EMAIL');
const _memberPassword = String.fromEnvironment('E2E_MEMBER_PASSWORD');
const _secondMemberEmail = String.fromEnvironment('E2E_SECOND_MEMBER_EMAIL');
const _secondMemberPassword = String.fromEnvironment(
  'E2E_SECOND_MEMBER_PASSWORD',
);

void main() async {
  await bootstrap(
    firebaseOptions: _firebaseOptions,
    environment: AppEnvironment.local,
    grpcHost: '127.0.0.1',
    grpcPort: 9090,
    useSecureGrpc: false,
    appTitle: 'Family Chat (E2E)',
    beforeRunApp: () async {
      final persona = Uri.base.queryParameters['e2eAuth'];
      final (email, password) = switch (persona) {
        'owner' => (_ownerEmail, _ownerPassword),
        'member' => (_memberEmail, _memberPassword),
        'secondMember' => (_secondMemberEmail, _secondMemberPassword),
        _ => ('', ''),
      };
      if (email.isEmpty) return;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    },
  );
}
