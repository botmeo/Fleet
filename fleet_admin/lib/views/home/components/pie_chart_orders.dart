import 'package:fleet_admin/models/statistical_data.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartOrders extends StatelessWidget {
  const PieChartOrders({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    NumberFormat formatter = NumberFormat("#.##", "en_EN");

    return FutureBuilder(
      future: orderViewModel.countOrdersWithOptimize(),
      builder: (context, snapshot) {
        return Container(
          height: 250,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SfCircularChart(
            palette: const [
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
            title: ChartTitle(
              text: 'Route optimization orders rate',
              textStyle: const TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFonts.fontsPrimary,
                fontWeight: AppFonts.boldFonts,
                fontSize: 12,
              ),
            ),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.scroll,
              textStyle: const TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFonts.fontsPrimary,
                fontWeight: AppFonts.boldFonts,
                fontSize: 12,
              ),
            ),
            series: <CircularSeries>[
              PieSeries<StatisticalData, String>(
                dataSource: orderViewModel.ordersWithOptimize,
                xValueMapper: (StatisticalData data, _) =>
                    data.itemName.toString(),
                yValueMapper: (StatisticalData data, _) => double.parse(
                  formatter.format(
                      (data.amount / orderViewModel.totalOrdersOptimize) * 100),
                ),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    color: AppColors.backgroundColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.boldFonts,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
