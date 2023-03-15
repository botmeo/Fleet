import 'package:fleet_driver/routes/routes.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  const SizedBox(
                    width: 2,
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
                    ],
                  ),
                ],
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                color: AppColors.primaryColor,
                size: 14,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.changePassword);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Languages',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.boldFonts,
                          fontSize: 14,
                        ),
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
              onTap: () {
                // Navigator.pushNamed(context, Routes.languages);
              },
            ),
            ListTile(
              title: Row(
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.boldFonts,
                          fontSize: 14,
                        ),
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
