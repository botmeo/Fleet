import 'package:fleet_admin/models/drivers.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/views/drivers/components/count_cancel_orders.dart';
import 'package:fleet_admin/views/drivers/components/count_complete_orders.dart';
import 'package:fleet_admin/views/drivers/components/count_ongoing_orders.dart';
import 'package:fleet_admin/views/drivers/components/count_pending_orders.dart';
import 'package:fleet_admin/views/drivers/components/row_info_driver.dart';
import 'package:fleet_admin/widgets/divider.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoDriverScreen extends StatelessWidget {
  const InfoDriverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverViewModel = Provider.of<DriverViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Information Driver',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Drivers>>(
          stream: driverViewModel.driverWithId,
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
                            CupertinoIcons.person_2_fill,
                            color: AppColors.primaryColor,
                            size: 55,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'There are no drivers',
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
                            'You can add drivers for business',
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
                      RowInfoDriver(
                        title: data[0].name,
                        subTitle: 'Name',
                      ),
                      const DividerComponent(),
                      RowInfoDriver(
                        title: data[0].birthday,
                        subTitle: 'Date of birth',
                      ),
                      const DividerComponent(),
                      RowInfoDriver(
                        title: data[0].phone,
                        subTitle: 'Phone',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Expanded(
                      child: CountPendingDriverOrders(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountOngoingDriverOrders(),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Expanded(
                      child: CountCompleteDriverOrders(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CountCancelDriverOrders(),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
