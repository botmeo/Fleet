import 'package:fleet_driver/models/user.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/routes/routes.dart';
import 'package:fleet_driver/viewmodels/user_view_model.dart';
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
                child: StreamBuilder<List<DriverUser>>(
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
                            'Driver',
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
                            'Driver',
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
                //     Icons.home,
                //     color: AppColors.primaryColor,
                //     size: 26,
                //   ),
                //   title: const Text(
                //     'Home',
                //     style: TextStyle(
                //       fontFamily: AppFonts.fontsPrimary,
                //       color: AppColors.primaryColor,
                //       fontSize: 14,
                //     ),
                //   ),
                //   onTap: () {},
                // ),
                // ListTile(
                //   leading: const Icon(
                //     CupertinoIcons.cube_box_fill,
                //     color: AppColors.primaryColor,
                //     size: 26,
                //   ),
                //   title: const Text(
                //     'Task',
                //     style: TextStyle(
                //       fontFamily: AppFonts.fontsPrimary,
                //       color: AppColors.primaryColor,
                //       fontSize: 14,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.pushNamed(context, Routes.ordersToday);
                //   },
                // ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.bus,
                    color: AppColors.primaryColor,
                    size: 26,
                  ),
                  title: const Text(
                    "Vehicles",
                    style: TextStyle(
                      fontFamily: AppFonts.fontsPrimary,
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, Routes.vehicles);
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
                //       fontSize: 14,
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
