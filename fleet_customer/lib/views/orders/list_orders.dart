import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/views/orders/pages/cancel/cancel_orders.dart';
import 'package:fleet_customer/views/orders/pages/complete/complete_orders.dart';
import 'package:fleet_customer/views/orders/pages/ongoing/ongoing_orders.dart';
import 'package:fleet_customer/views/orders/pages/pending/pending_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOrdersScreen extends StatelessWidget {
  const ListOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: true,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Orders',
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
            ),
          ),
        ),
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
                  Tab(text: 'Pending'),
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Complete'),
                  Tab(text: 'Cancel'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    PendingOrdersPage(),
                    OngoingOrdersPage(),
                    CompleteOrdersPage(),
                    CancelOrdersPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.createOrder);
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            CupertinoIcons.add,
            color: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
