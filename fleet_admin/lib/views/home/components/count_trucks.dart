import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountTrucks extends StatelessWidget {
  const CountTrucks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truckViewModel = Provider.of<TruckViewModel>(context);

    return FutureBuilder(
      future: truckViewModel.countTrucks(),
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
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
                          'Trucks',
                          style: TextStyle(
                            color: AppColors.ongoingColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          truckViewModel.trucksCount.toString(),
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
