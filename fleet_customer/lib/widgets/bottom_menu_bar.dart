import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomMenuBar extends StatelessWidget {
  const BottomMenuBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
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
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
      ],
    );
  }
}
