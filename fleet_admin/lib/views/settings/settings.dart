import 'package:fleet_admin/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

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
                  const Icon(
                    CupertinoIcons.building_2_fill,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Address',
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
                // Navigator.pushNamed(context, Routes.address);
              },
            ),
          ],
        ),
      ),
    );
  }
}
