import 'package:fleet_admin/models/drivers.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoDriverOrder extends StatelessWidget {
  const InfoDriverOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driversViewModel = Provider.of<DriverViewModel>(context);

    return StreamBuilder<List<Drivers>>(
      stream: driversViewModel.driverWithId,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: ColorLoader(),
          );
        }
        final data = snapshot.data;
        if (data.isEmpty) {
          return const Text(
            'No infomation driver',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
              fontSize: 14,
            ),
          );
        }
        final driver = data[0];
        return Text(
          '${driver.name} | ${driver.phone}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.subTextColor,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.regularFonts,
            fontSize: 14,
          ),
        );
      },
    );
  }
}
