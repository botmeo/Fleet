import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleet_admin/routes/pages.dart';
import 'package:fleet_admin/theme.dart';
import 'package:fleet_admin/viewmodels/base_view_model.dart';
import 'package:fleet_admin/viewmodels/customer_view_model.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/viewmodels/google_map_view_model.dart';
import 'package:fleet_admin/viewmodels/order_view_model.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/viewmodels/user_view_model.dart';
import 'package:fleet_admin/views/login/login.dart';
import 'package:flutter/foundation.dart';
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

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyByvylJ_HMS1erCyMMkPxtzLuvofLRonqk",
        authDomain: "fleet-truck-45e45.firebaseapp.com",
        databaseURL:
            "https://fleet-truck-45e45-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "fleet-truck-45e45",
        storageBucket: "fleet-truck-45e45.appspot.com",
        messagingSenderId: "319357560092",
        appId: "1:319357560092:web:0a2fa5d86a309128a506d9",
        measurementId: "G-P7V562SXLQ",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
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
        ChangeNotifierProvider(create: (_) => CustomerViewModel()),
        ChangeNotifierProvider(create: (_) => DriverViewModel()),
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
