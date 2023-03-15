import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawerCustom extends StatelessWidget {
  const NavigationDrawerCustom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              child: Container(
                color: AppColors.primaryColor,
                padding: EdgeInsets.only(
                  top: 30 + MediaQuery.of(context).padding.top,
                  bottom: 25,
                ),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 52,
                      // backgroundImage: ,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'admin',
                      style: TextStyle(
                        fontFamily: AppFonts.fontsPrimary,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'admin@gmail.com',
                      style: TextStyle(
                        fontFamily: AppFonts.fontsPrimary,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.dashboard_rounded,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontFamily: AppFonts.fontsPrimary,
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.home);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.cube_box_fill,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Orders',
                    style: TextStyle(
                      fontFamily: AppFonts.fontsPrimary,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.listOrders);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.person_2_fill,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Drivers',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.listDrivers);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.bus,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Trucks',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.listTrucks);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.group_solid,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Customers',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.listCustomers);
                  },
                ),
                // ListTile(
                //   leading: const Icon(
                //     CupertinoIcons.gear_alt_fill,
                //     color: AppColors.primaryColor,
                //     size: 26,
                //   ),
                //   title: const Text(
                //     'Settings',
                //     style: TextStyle(
                //       fontFamily: AppFonts.fontsPrimary,
                //       color: AppColors.primaryColor,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, Routes.settings);
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
