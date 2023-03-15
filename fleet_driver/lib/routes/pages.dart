import 'package:fleet_driver/routes/routes.dart';
import 'package:fleet_driver/views/forgot_password/forgot_password.dart';
import 'package:fleet_driver/views/home/home.dart';
import 'package:fleet_driver/views/login/login.dart';
import 'package:fleet_driver/views/orders/pages/history/cancel/cancel_order_details.dart';
import 'package:fleet_driver/views/orders/pages/history/complete/complete_order_details.dart';
import 'package:fleet_driver/views/orders/pages/today/today_ongoing_orders.dart';
import 'package:fleet_driver/views/orders/pages/today/today_order_details.dart';
import 'package:fleet_driver/views/orders/pages/today/today_orders.dart';
import 'package:fleet_driver/views/policy/policy.dart';
import 'package:fleet_driver/views/profile/change_password.dart';
import 'package:fleet_driver/views/profile/edit_profile.dart';
import 'package:fleet_driver/views/profile/profile.dart';
import 'package:fleet_driver/views/settings/pages/languages.dart';
import 'package:fleet_driver/views/settings/settings.dart';
import 'package:fleet_driver/views/vehicles/vehicles.dart';
import 'package:flutter/cupertino.dart';

abstract class Pages {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.login: (BuildContext context) => const LoginScreen(),
    Routes.forgotPassword: (BuildContext context) =>
        const ForgotPasswordScreen(),
    Routes.home: (BuildContext context) => const HomeScreen(),
    Routes.profile: (BuildContext context) => const ProfileScreen(),
    Routes.editProfile: (BuildContext context) => const EditProfileScreen(),
    Routes.ordersToday: (BuildContext context) => const TodayOrdersScreen(),
    Routes.todayOngoingOrder: (BuildContext context) =>
        const TodayOngoingScreen(),
    Routes.todayOrderDetails: (BuildContext context) =>
        const TodayOrderDetailsScreen(),
    Routes.cancelOrderDetails: (BuildContext context) =>
        const CancelOrderDetailsScreen(),
    Routes.completeOrderDetails: (BuildContext context) =>
        const CompleteOrderDetailsScreen(),
    Routes.vehicles: (BuildContext context) => const VehiclesScreen(),
    Routes.settings: (BuildContext context) => const SettingScreen(),
    Routes.changePassword: (BuildContext context) =>
        const ChangePasswordScreen(),
    Routes.languages: (BuildContext context) => const LanguagesPage(),
    Routes.policy: (BuildContext context) => const PolicyScreen(),
  };
}
