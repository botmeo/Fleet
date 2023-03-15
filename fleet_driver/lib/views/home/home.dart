import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/viewmodels/base_view_model.dart';
import 'package:fleet_driver/views/orders/pages/history/history_orders.dart';
import 'package:fleet_driver/views/orders/pages/today/today_orders.dart';
import 'package:fleet_driver/views/statistical/statistical.dart';
import 'package:fleet_driver/widgets/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseViewModel = Provider.of<BaseViewModel>(context);

    final pages = [
      const TodayOrdersScreen(),
      const HistoryOrdersScreen(),
      const StatisticalScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Fleet',
          style: TextStyle(
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const NavigationDrawerCustom(),
      body: pages[baseViewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: baseViewModel.currentIndex,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        selectedLabelStyle: const TextStyle(
          fontFamily: AppFonts.fontsPrimary,
          fontWeight: AppFonts.boldFonts,
        ),
        selectedFontSize: 0,
        unselectedLabelStyle: const TextStyle(
          fontFamily: AppFonts.fontsPrimary,
          fontWeight: AppFonts.boldFonts,
        ),
        unselectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.cube_box_fill,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.time_solid,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chart_pie_fill,
            ),
            label: 'Chart',
          ),
        ],
        onTap: (index) {
          baseViewModel.updateCurrentIndex(index);
        },
      ),
    );
  }
}
