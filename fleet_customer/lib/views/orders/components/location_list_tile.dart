import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  final String location;
  final VoidCallback press;

  const LocationListTile({
    Key key,
    this.location,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 2,
        ),
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Icon(
            CupertinoIcons.map_pin_ellipse,
            color: AppColors.secondaryColor,
          ),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.regularFonts,
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
