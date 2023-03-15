import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/base_view_model.dart';
import 'package:fleet_admin/views/home/pages/statistical_all.dart';
import 'package:fleet_admin/views/home/pages/statistical_order.dart';
import 'package:fleet_admin/widgets/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseViewModel = Provider.of<BaseViewModel>(context);

    final pages = [
      const StatisticalOrderScreen(),
      const StatisticalAllScreen(),
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
              CupertinoIcons.chart_pie_fill,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_2_fill,
            ),
            label: 'All',
          ),
        ],
        onTap: (index) {
          baseViewModel.updateCurrentIndex(index);
        },
      ),
    );
  }
}
