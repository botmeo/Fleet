import 'package:fleet_admin/views/home/components/count_customers.dart';
import 'package:fleet_admin/views/home/components/count_drivers.dart';
import 'package:fleet_admin/views/home/components/count_trucks.dart';
import 'package:flutter/material.dart';

class StatisticalAllScreen extends StatelessWidget {
  const StatisticalAllScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: CountCustomers(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountDrivers(),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: CountTrucks(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
