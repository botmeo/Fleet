import 'package:fleet_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class RowInfoDriver extends StatelessWidget {
  final String title;
  final String subTitle;

  const RowInfoDriver({
    Key key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            subTitle,
            style: const TextStyle(
              color: AppColors.subTextColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.regularFonts,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
