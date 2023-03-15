import 'package:fleet_customer/models/customers.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Customers>>(
          stream: userViewModel.infoUser,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Divider(
                color: AppColors.backgroundColor,
                height: 0,
              );
            }
            final data = snapshot.data;
            if (data.isEmpty) {
              return const Divider(
                color: AppColors.backgroundColor,
                height: 0,
              );
            }
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                  padding: const EdgeInsets.all(6),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.editProfile,
                        arguments: {
                          'name': data[0].name,
                          'phone': data[0].phone,
                        },
                      );
                    },
                    title: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.person_fill,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              data[0].name,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              data[0].email,
                              style: const TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      CupertinoIcons.chevron_forward,
                      color: AppColors.primaryColor,
                      size: 14,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                  padding: const EdgeInsets.all(6),
                  child: ListTile(
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.changePassword);
                    },
                    title: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.lock_fill,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Change password',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Change password of your account',
                              style: TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                  padding: const EdgeInsets.all(6),
                  child: ListTile(
                    onTap: () {
                      userViewModel.signOut(context);
                    },
                    title: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.arrowshape_turn_up_left_circle_fill,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Sign out of your account',
                              style: TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
