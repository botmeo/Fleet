import 'package:fleet_driver/views/statistical/components/bar_chart_orders.dart';
import 'package:fleet_driver/views/statistical/components/count_cancel_orders.dart';
import 'package:fleet_driver/views/statistical/components/count_complete_orders.dart';
import 'package:fleet_driver/views/statistical/components/line_chart_orders_days.dart';
import 'package:flutter/material.dart';

class StatisticalScreen extends StatelessWidget {
  const StatisticalScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
