import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/viewmodels/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountPendingDriverOrders extends StatelessWidget {
  const CountPendingDriverOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverViewModel = Provider.of<DriverViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return FutureBuilder(
      future: orderViewModel.countPendingOrdersDriver(driverViewModel.idDriver),
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pending',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          orderViewModel.pendingOrdersDriverCount.toString(),
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
