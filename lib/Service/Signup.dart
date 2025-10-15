import 'package:firebase_auth/firebase_auth.dart';

class AuthFailure implements Exception {
  AuthFailure(this.message);

  final String message;
}

class AuthSignupService {
  AuthSignupService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw AuthFailure('Email and password are required.');
    }

    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthFailure(error.message ?? 'Sign up failed. Please try again.');
    } catch (_) {
      throw AuthFailure('Unexpected error. Please try again later.');
    }
  }
}
