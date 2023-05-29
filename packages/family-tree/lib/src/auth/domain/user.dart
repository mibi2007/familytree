import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    required String id,
    required String email,
    required String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirebaseAuth(firebase_auth.User? fbUser) {
    if (fbUser == null) {
      return User.empty();
    }
    return User(
      id: fbUser.uid,
      email: fbUser.email ?? '',
      name: fbUser.displayName ?? '',
    );
  }

  factory User.empty() => const User(id: '', email: '', name: '');
}
