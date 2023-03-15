import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowInfoOrder extends StatelessWidget {
  final String title;
  final IconData icon;

  const RowInfoOrder({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.secondaryColor,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.regularFonts,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
