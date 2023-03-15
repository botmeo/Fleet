import 'package:fleet_driver/models/trucks.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/viewmodels/truck_view_model.dart';
import 'package:fleet_driver/views/vehicles/components/line_chart_truck.dart';
import 'package:fleet_driver/views/vehicles/components/row_info_truck.dart';
import 'package:fleet_driver/widgets/divider.dart';
import 'package:fleet_driver/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truckViewModel = Provider.of<TruckViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Vehicles',
          style: TextStyle(
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Trucks>>(
          stream: truckViewModel.infoTruck,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: ColorLoader(),
              );
            }
            final data = snapshot.data;
            if (data.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.bus,
                            color: AppColors.primaryColor,
                            size: 55,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'There are no active trucks',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.regularFonts,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'You can add trucks for business',
                            style: TextStyle(
                              color: AppColors.subTextColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.regularFonts,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
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
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Information',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
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
                      const DividerComponent(),
                      RowInfoTruck(
                        title: data[0].licensePlate,
                        subTitle: 'License Plate',
                      ),
                      const DividerComponent(),
                      RowInfoTruck(
                        title: data[0].model,
                        subTitle: 'Model',
                      ),
                      const DividerComponent(),
                      RowInfoTruck(
                        title: data[0].year,
                        subTitle: 'Year',
                      ),
                      const DividerComponent(),
                      RowInfoTruck(
                        title: data[0].manufacture,
                        subTitle: 'Manufacture',
                      ),
                      const DividerComponent(),
                      RowInfoTruck(
                        title: '${data[0].capacity} kg',
                        subTitle: 'Capacity',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const LineChartTruck(),
              ],
            );
          },
        ),
      ),
    );
  }
}
