import 'package:fleet_admin/models/trucks.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/views/orders/components/info_driver_order.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoTruckOrder extends StatelessWidget {
  const InfoTruckOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trucksViewModel = Provider.of<TruckViewModel>(context);
    final driversViewModel = Provider.of<DriverViewModel>(context);

    return StreamBuilder<List<Trucks>>(
      stream: trucksViewModel.truckWithId,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: ColorLoader(),
          );
        }
        final data = snapshot.data;
        if (data.isEmpty) {
          return const ListTile(
            horizontalTitleGap: 0,
            title: Text(
              'No infomation truck',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: AppFonts.fontsPrimary,
                fontWeight: AppFonts.boldFonts,
                fontSize: 14,
              ),
            ),
          );
        }
        final truck = data[0];
        driversViewModel.updateIdDriver(truck.used);

        return ListTile(
          leading: const Icon(
            CupertinoIcons.bus,
            color: AppColors.secondaryColor,
          ),
          horizontalTitleGap: 0,
          title: Text(
            truck.licensePlate,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
              fontSize: 14,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${truck.capacity} kg' ?? 'No information',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.subTextColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.regularFonts,
                  fontSize: 14,
                ),
              ),
              const InfoDriverOrder(),
            ],
          ),
        );
      },
    );
  }
}
