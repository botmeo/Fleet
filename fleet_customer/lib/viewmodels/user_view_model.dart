import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_customer/models/customers.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/services/auth_service.dart';
import 'package:fleet_customer/services/user_service.dart';
import 'package:fleet_customer/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserService userService = UserService();
  final AuthService authService = AuthService();
  int value;
  double currentBalance = 0;
  double currentNewBalance = 0;
  double newBalance = 0;

  Stream<List<Customers>> get infoUser {
    return userService.getInfoUser();
  }

  void updateProfile(Customers customers) {
    userService.updateProfile(customers);
    notifyListeners();
  }

  Future<void> getBalance() async {
    currentBalance = await userService.getBalance();
    notifyListeners();
  }

  void topUpAccount() {
    userService.changeBalanceAccount(newBalance);
  }

  void deductFromAccount(double value) {
    userService.changeBalanceAccount(value);
  }

  void updateCurrentBalance(double value) {
    currentNewBalance = value;
  }

  void changBalanceUser(int ind, double valueBalance) {
    value = ind;
    newBalance = currentNewBalance + valueBalance;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    Customers customer,
    context,
  ) async {
    try {
      await authService
          .signUpWithEmailAndPassword(email, password, customer, context)
          .then(
        (value) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (Route<dynamic> route) => false,
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code.toString()) {
        case 'invalid-email':
          showErrorDialog(
            context,
            'Sign-up',
            'Invalid email.',
          );
          break;
        case 'email-already-in-use':
          showErrorDialog(
            context,
            'Sign-up',
            'Email already in use.',
          );
          break;
        default:
          showErrorDialog(
            context,
            'Sign-up',
            'Sign up failed, please try again.',
          );
          break;
      }
    }
  }

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

  Future<void> forgotPassword(context, String email) async {
    try {
      await authService.forgotPassword(email);
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      switch (error.code.toString()) {
        case 'invalid-email':
          showErrorDialog(
            context,
            'Forgot',
            'Invalid email.',
          );
          break;
        case 'user-not-found':
          showErrorDialog(
            context,
            'Forgot',
            'Incorrect email.',
          );
          break;
        default:
          showErrorDialog(
            context,
            'Forgot',
            'Failed, please try again.',
          );
          break;
      }
    }
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
