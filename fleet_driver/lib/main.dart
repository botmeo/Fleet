import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleet_driver/routes/pages.dart';
import 'package:fleet_driver/theme.dart';
import 'package:fleet_driver/viewmodels/base_view_model.dart';
import 'package:fleet_driver/viewmodels/google_map_view_model.dart';
import 'package:fleet_driver/viewmodels/order_view_model.dart';
import 'package:fleet_driver/viewmodels/truck_view_model.dart';
import 'package:fleet_driver/viewmodels/user_view_model.dart';
import 'package:fleet_driver/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => TruckViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
        ChangeNotifierProvider(create: (_) => GoogleMapViewModel()),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
        routes: Pages.routes,
        theme: theme(),
      ),
    );
  }
}
