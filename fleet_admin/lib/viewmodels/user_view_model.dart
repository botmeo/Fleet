import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/services/auth_service.dart';
import 'package:fleet_admin/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final AuthService authService = AuthService();

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    context,
  ) async {
    try {
      await authService.signInWithEmailAndPassword(email, password).then(
        (value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (Route<dynamic> route) => false,
          );
        },
      );
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      switch (error.code.toString()) {
        case 'invalid-email':
          showErrorDialog(
            context,
            'Sign-in',
            'Invalid email.',
          );
          break;
        case 'user-not-found':
          showErrorDialog(
            context,
            'Sign-in',
            'Incorrect email or password.',
          );
          break;
        case 'wrong-password':
          showErrorDialog(
            context,
            'Sign-in',
            'Incorrect email or password.',
          );
          break;
        default:
          showErrorDialog(
            context,
            'Sign-in',
            'Sign in failed, please try again.',
          );
          break;
      }
    }
  }

  Future<void> signOut(context) async {
    await authService.signOut().then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Future<void> changePassword(context, String newPassword) async {
    await authService.changePassword(newPassword).then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) => NotificationDialog(
        title: Text(title),
        content: Text(content),
      ),
    );
  }
}
