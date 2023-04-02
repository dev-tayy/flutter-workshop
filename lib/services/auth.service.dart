import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAccountName({required String name}) async {
    try {
      await auth.currentUser?.updateDisplayName(name);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
