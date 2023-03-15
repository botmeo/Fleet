import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/views/customers/info_customer.dart';
import 'package:fleet_admin/views/customers/list_customers.dart';
import 'package:fleet_admin/views/drivers/add_driver.dart';
import 'package:fleet_admin/views/drivers/edit_driver.dart';
import 'package:fleet_admin/views/drivers/info_driver.dart';
import 'package:fleet_admin/views/drivers/list_drivers.dart';
import 'package:fleet_admin/views/drivers/select_truck.dart';
import 'package:fleet_admin/views/home/home.dart';
import 'package:fleet_admin/views/login/login.dart';
import 'package:fleet_admin/views/orders/list_orders.dart';
import 'package:fleet_admin/views/orders/pages/cancel/cancel_order_details.dart';
import 'package:fleet_admin/views/orders/pages/complete/complete_order_details.dart';
import 'package:fleet_admin/views/orders/pages/ongoing/ongoing_order_details.dart';
import 'package:fleet_admin/views/orders/pages/pending/pending_order_details.dart';
import 'package:fleet_admin/views/profile/change_password.dart';
import 'package:fleet_admin/views/profile/profile.dart';
import 'package:fleet_admin/views/settings/settings.dart';
import 'package:fleet_admin/views/trucks/add_truck.dart';
import 'package:fleet_admin/views/trucks/edit_truck.dart';
import 'package:fleet_admin/views/trucks/info_truck.dart';
import 'package:fleet_admin/views/trucks/list_trucks.dart';
import 'package:fleet_admin/views/trucks/location_truck.dart';
import 'package:flutter/cupertino.dart';

abstract class Pages {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.login: (BuildContext context) => const LoginScreen(),
    Routes.home: (BuildContext context) => const HomeScreen(),
    Routes.listOrders: (BuildContext context) => const ListOrdersScreen(),
    Routes.pendingOrderDetails: (BuildContext context) =>
        const PendingOrderDetailsScreen(),
    Routes.ongoingOrderDetails: (BuildContext context) =>
        const OngoingOrderDetailsScreen(),
    Routes.completeOrderDetails: (BuildContext context) =>
        const CompleteOrderDetailsScreen(),
    Routes.cancelOrderDetails: (BuildContext context) =>
        const CancelOrderDetailsScreen(),
    Routes.listTrucks: (BuildContext context) => const ListTrucksScreen(),
    Routes.addTruck: (BuildContext context) => const AddTruckScreen(),
    Routes.editTruck: (BuildContext context) => const EditTruckScreen(),
    Routes.infoTruck: (BuildContext context) => const InfoTruckScreen(),
    Routes.locationTruck: (BuildContext context) => const LocationTruck(),
    Routes.listDrivers: (BuildContext context) => const ListDriversScreen(),
    Routes.addDriver: (BuildContext context) => const AddDriverScreen(),
    Routes.editDriver: (BuildContext context) => const EditDriverScreen(),
    Routes.infoDriver: (BuildContext context) => const InfoDriverScreen(),
    Routes.selectTruck: (BuildContext context) => const SelectTruckScreen(),
    Routes.listCustomers: (BuildContext context) => const ListCustomersScreen(),
    Routes.infoCustomer: (BuildContext context) => const InfoCustomerScreen(),
    Routes.profile: (BuildContext context) => const ProfileScreen(),
    Routes.changePassword: (BuildContext context) =>
        const ChangePasswordScreen(),
    Routes.settings: (BuildContext context) => const SettingsScreen(),
  };
}
