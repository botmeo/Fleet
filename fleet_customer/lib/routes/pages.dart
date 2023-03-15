import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/views/favorite/favorite_driver.dart';
import 'package:fleet_customer/views/forgot_password/forgot_password.dart';
import 'package:fleet_customer/views/home/home.dart';
import 'package:fleet_customer/views/login/login.dart';
import 'package:fleet_customer/views/orders/pages/current/confirm_order.dart';
import 'package:fleet_customer/views/orders/pages/current/create_order.dart';
import 'package:fleet_customer/views/orders/list_orders.dart';
import 'package:fleet_customer/views/orders/pages/current/order_details.dart';
import 'package:fleet_customer/views/orders/pages/cancel/cancel_order_details.dart';
import 'package:fleet_customer/views/orders/pages/complete/complete_order_details.dart';
import 'package:fleet_customer/views/orders/pages/current/drop_off/drop_off_location.dart';
import 'package:fleet_customer/views/orders/pages/current/drop_off/drop_off_search.dart';
import 'package:fleet_customer/views/orders/pages/current/mid_stop/mid_stop_location.dart';
import 'package:fleet_customer/views/orders/pages/current/mid_stop/mid_stop_search.dart';
import 'package:fleet_customer/views/orders/pages/current/pickup/pickup_location.dart';
import 'package:fleet_customer/views/orders/pages/current/pickup/pickup_search.dart';
import 'package:fleet_customer/views/orders/pages/ongoing/ongoing_order_details.dart';
import 'package:fleet_customer/views/orders/pages/pending/pending_order_details.dart';
import 'package:fleet_customer/views/orders/pages/current/select_vehicle.dart';
import 'package:fleet_customer/views/profile/change_password.dart';
import 'package:fleet_customer/views/profile/edit_profile.dart';
import 'package:fleet_customer/views/profile/profile.dart';
import 'package:fleet_customer/views/signup/signup.dart';
import 'package:fleet_customer/views/wallet/top_up.dart';
import 'package:fleet_customer/views/wallet/wallet.dart';
import 'package:flutter/cupertino.dart';

abstract class Pages {
  static Map<String, Widget Function(BuildContext)> routes = {
    Routes.login: (BuildContext context) => const LoginScreen(),
    Routes.signup: (BuildContext context) => const SignUpScreen(),
    Routes.forgotPassword: (BuildContext context) =>
        const ForgotPasswordScreen(),
    Routes.home: (BuildContext context) => const HomeScreen(),
    Routes.listOrders: (BuildContext context) => const ListOrdersScreen(),
    Routes.orderDetails: (BuildContext context) => const OrderDetailsScreen(),
    Routes.createOrder: (BuildContext context) => const CreateOrderScreen(),
    Routes.pendingOrderDetails: (BuildContext context) =>
        const PendingOrderDetailsScreen(),
    Routes.ongoingOrderDetails: (BuildContext context) =>
        const OngoingOrderDetailsScreen(),
    Routes.completeOrderDetails: (BuildContext context) =>
        const CompleteOrderDetailsScreen(),
    Routes.cancelOrderDetails: (BuildContext context) =>
        const CancelOrderDetailsScreen(),
    Routes.currentOrderDetails: (BuildContext context) =>
        const OrderDetailsScreen(),
    Routes.pickUpLocation: (BuildContext context) => PickUpLocationScreen(),
    Routes.pickUpSearch: (BuildContext context) => const PickUpSearchScreen(),
    Routes.dropOffLocation: (BuildContext context) => DropOffLocationScreen(),
    Routes.dropOffSearch: (BuildContext context) => const DropOffSearchScreen(),
    Routes.midStopLocation: (BuildContext context) => MidStopLocationScreen(),
    Routes.midStopSearch: (BuildContext context) => const MidStopSearchScreen(),
    Routes.selectVehicle: (BuildContext context) => const SelectVehicleScreen(),
    Routes.confirmOrder: (BuildContext context) => const ConfirmOrderScreen(),
    Routes.profile: (BuildContext context) => const ProfileScreen(),
    Routes.editProfile: (BuildContext context) => const EditProfileScreen(),
    Routes.changePassword: (BuildContext context) =>
        const ChangePasswordScreen(),
    Routes.wallet: (BuildContext context) => const WalletScreen(),
    Routes.topUp: (BuildContext context) => const TopUpScreen(),
    Routes.favoriteDriver: (BuildContext context) =>
        const FavoriteDriverScreen(),
  };
}
