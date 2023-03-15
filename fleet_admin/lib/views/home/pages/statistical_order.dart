import 'package:fleet_admin/views/home/components/bar_chart_orders.dart';
import 'package:fleet_admin/views/home/components/count_cancel_orders.dart';
import 'package:fleet_admin/views/home/components/count_complete_orders.dart';
import 'package:fleet_admin/views/home/components/count_ongoing_orders.dart';
import 'package:fleet_admin/views/home/components/count_pending_orders.dart';
import 'package:fleet_admin/views/home/components/pie_chart_orders.dart';
import 'package:flutter/material.dart';

class StatisticalOrderScreen extends StatelessWidget {
  const StatisticalOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: PieChartOrders(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
