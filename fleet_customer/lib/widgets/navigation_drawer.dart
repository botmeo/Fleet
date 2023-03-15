import 'package:fleet_customer/models/customers.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerCustom extends StatelessWidget {
  const NavigationDrawerCustom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

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
                child: StreamBuilder<List<Customers>>(
                  stream: userViewModel.infoUser,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        children: const [
                          CircleAvatar(
                            radius: 52,
                            // backgroundImage: ,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Customer',
                            style: TextStyle(
                              fontFamily: AppFonts.fontsPrimary,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0378917214',
                            style: TextStyle(
                              fontFamily: AppFonts.fontsPrimary,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    final data = snapshot.data;
                    if (data.isEmpty) {
                      return Column(
                        children: const [
                          CircleAvatar(
                            radius: 52,
                            // backgroundImage: ,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Drivers',
                            style: TextStyle(
                              fontFamily: AppFonts.fontsPrimary,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0378917214',
                            style: TextStyle(
                              fontFamily: AppFonts.fontsPrimary,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const CircleAvatar(
                          radius: 52,
                          // backgroundImage: ,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          data[0].name,
                          style: const TextStyle(
                            fontFamily: AppFonts.fontsPrimary,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data[0].phone,
                          style: const TextStyle(
                            fontFamily: AppFonts.fontsPrimary,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                // ListTile(
                //   leading: const Icon(
                //     Icons.dashboard_rounded,
                //     color: AppColors.primaryColor,
                //     size: 26,
                //   ),
                //   title: const Text(
                //     'Dashboard',
                //     style: TextStyle(
                //       fontFamily: AppFonts.fontsPrimary,
                //       color: AppColors.primaryColor,
                //       fontSize: 14,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, Routes.home);
                //   },
                // ),
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
                    CupertinoIcons.money_dollar_circle_fill,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    'Wallet',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.wallet);
                  },
                ),
                // ListTile(
                //   leading: const Icon(
                //     CupertinoIcons.heart_fill,
                //     color: AppColors.primaryColor,
                //     size: 26,
                //   ),
                //   title: const Text(
                //     'Favorite driver',
                //     style: TextStyle(
                //       color: AppColors.primaryColor,
                //       fontFamily: AppFonts.fontsPrimary,
                //       fontSize: 14,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, Routes.favoriteDriver);
                //   },
                // ),
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
