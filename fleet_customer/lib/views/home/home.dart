import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/views/home/components/bar_chart_orders.dart';
import 'package:fleet_customer/views/home/components/count_cancel_orders.dart';
import 'package:fleet_customer/views/home/components/count_complete_orders.dart';
import 'package:fleet_customer/views/home/components/count_ongoing_orders.dart';
import 'package:fleet_customer/views/home/components/count_pending_orders.dart';
import 'package:fleet_customer/views/home/components/line_chart_orders_days.dart';
import 'package:fleet_customer/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Fleet',
          style: TextStyle(
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: NavigationDrawerCustom(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: CountPendingOrders(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountOngoingOrders(),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: CountCompleteOrders(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CountCancelOrders(),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: BarChartOrders(),
                ),
              ],
            ),
            Row(
              children: const [
                Expanded(
                  child: LineChartOrdersDays(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
