import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_admin/models/drivers.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/services/auth_service.dart';
import 'package:fleet_admin/services/driver_service.dart';
import 'package:fleet_admin/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

class DriverViewModel extends ChangeNotifier {
  final DriverService driverService = DriverService();
  final AuthService authService = AuthService();
  String idDriver = '';
  String query = '';
  int driversCount = 0;

  Stream<List<Drivers>> get listDrivers {
    return driverService.getListDrivers();
  }

  Stream<List<Drivers>> get driverWithId {
    return driverService.getDriverWithId(idDriver);
  }

  Future<void> addDriverAndSignUp(
    String email,
    Drivers driver,
    context,
  ) async {
    try {
      await authService.createUserWithEmailAndPassword(email).then((value) {
        User user = FirebaseAuth.instance.currentUser;
        driverService.createInfoDriver(user.uid, driver);
        Navigator.pushNamed(context, Routes.selectTruck);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code.toString()) {
        case 'invalid-email':
          showErrorDialog(
            context,
            'Error',
            'Invalid email.',
          );
          break;
        case 'email-already-in-use':
          showErrorDialog(
            context,
            'Error',
            'Email already in use.',
          );
          break;
        default:
          showErrorDialog(
            context,
            'Error',
            'Sign up failed, please try again.',
          );
          break;
      }
    }
  }

  Future<void> updateDriver(Drivers driver) async {
    await driverService.updateDriver(driver);
    notifyListeners();
  }

  Future<void> deleteDriver(String id) async {
    await driverService.deleteDriver(id);
    notifyListeners();
  }

  Stream<List<Drivers>> searchDriver(String query) {
    return driverService.searchDriver(query);
  }

  Future<void> countDrivers() async {
    driversCount = await driverService.countDrivers();
    notifyListeners();
  }

  void updateIdDriver(String value) {
    idDriver = value;
    notifyListeners();
  }

  void updateValueQuery(String value) {
    query = value;
    notifyListeners();
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
