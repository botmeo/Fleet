import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/views/orders/pages/history/cancel/cancel_orders.dart';
import 'package:fleet_driver/views/orders/pages/history/complete/complete_orders.dart';
import 'package:flutter/material.dart';

class HistoryOrdersScreen extends StatelessWidget {
  const HistoryOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey.withOpacity(0.8),
                labelStyle: const TextStyle(
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.boldFonts,
                ),
                tabs: const [
                  Tab(
                    text: 'Complete',
                  ),
                  Tab(
                    text: 'Cancel',
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    HistoryCompleteOrdersPage(),
                    HistoryCancelOrdersPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
