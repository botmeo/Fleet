import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final Widget title;
  final Widget content;

  const NotificationDialog({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      titleTextStyle: const TextStyle(
        color: AppColors.secondaryColor,
        fontFamily: AppFonts.fontsPrimary,
        fontWeight: AppFonts.boldFonts,
        fontSize: 20,
      ),
      content: content,
      contentTextStyle: const TextStyle(
        color: AppColors.primaryColor,
        fontFamily: AppFonts.fontsPrimary,
        fontWeight: AppFonts.regularFonts,
        fontSize: 14,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Ok',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
              fontSize: 14,
            ),
          ),
        )
      ],
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
