import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await firebaseAuth.currentUser.updatePassword(newPassword);
      firebaseAuth.signOut();
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      return error.toString();
    }
  }
}
