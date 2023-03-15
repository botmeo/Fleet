import 'package:fleet_customer/models/statistical_data.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartOrdersDays extends StatelessWidget {
  const LineChartOrdersDays({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderViewModel>(
      create: (context) => OrderViewModel(),
      child: Consumer<OrderViewModel>(
        builder: (context, orderViewModel, child) {
          return FutureBuilder(
            future: orderViewModel.countOrdersLast7Days(),
            builder: (context, snapshot) {
              return Container(
                height: 280,
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
                child: SfCartesianChart(
                  palette: const [
                    AppColors.secondaryColor,
                  ],
                  title: ChartTitle(
                    text: 'Number of orders in the last 7 days',
                    textStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 12,
                    ),
                  ),
                  primaryXAxis: CategoryAxis(
                    labelStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 12,
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 60,
                    interval: 15,
                    labelStyle: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 12,
                    ),
                  ),
                  series: <ChartSeries<StatisticalData, String>>[
                    LineSeries<StatisticalData, String>(
                      dataSource: orderViewModel.ordersLast7Day,
                      xValueMapper: (StatisticalData data, _) => data.itemName,
                      yValueMapper: (StatisticalData data, _) => data.amount,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: AppColors.primaryColor,
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
        },
      ),
    );
  }
}
