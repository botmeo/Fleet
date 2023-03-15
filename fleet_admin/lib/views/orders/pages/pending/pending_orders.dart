import 'package:fleet_admin/models/directions_point.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/models/orders.dart';
import 'package:fleet_admin/viewmodels/google_map_view_model.dart';
import 'package:fleet_admin/viewmodels/order_view_model.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final truckViewModel = Provider.of<TruckViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return StreamBuilder<List<Orders>>(
      stream: orderViewModel.pendingOrders,
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
                        CupertinoIcons.cube_box_fill,
                        color: AppColors.primaryColor,
                        size: 55,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'No orders available at the moment',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.regularFonts,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final order = data[index];
            return GestureDetector(
              onTap: () {
                orderViewModel.updateIdOrder(order.id);
                truckViewModel.updateIdTruck(order.idTruck);
                mapViewModel.addPickUpMarker(
                  order.pickUpPoint[0].address,
                  order.pickUpPoint[0].lat,
                  order.pickUpPoint[0].lng,
                );
                mapViewModel.addDropOffMarker(
                  order.dropOffPoint[0].address,
                  order.dropOffPoint[0].lat,
                  order.dropOffPoint[0].lng,
                );
                if (order.stopPoint.isNotEmpty) {
                  mapViewModel.addStopMarker(
                    order.stopPoint.length,
                    order.stopPoint,
                  );
                  mapViewModel.addWayPoints(
                    order.stopPoint.length,
                    order.stopPoint,
                  );
                }
                mapViewModel.getDirections(
                  DirectionPoint(
                    startLat: order.pickUpPoint[0].lat,
                    startLng: order.pickUpPoint[0].lng,
                    endLat: order.dropOffPoint[0].lat,
                    endLng: order.dropOffPoint[0].lng,
                  ),
                );
                mapViewModel.setCustomMarker();
                Navigator.pushNamed(context, Routes.pendingOrderDetails);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                  border: const Border(
                    top: BorderSide(
                      color: AppColors.secondaryColor,
                    ),
                    left: BorderSide(
                      color: AppColors.secondaryColor,
                    ),
                    right: BorderSide(
                      color: AppColors.secondaryColor,
                    ),
                    bottom: BorderSide(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.time_solid,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          DateFormat.yMMMMd('en_US')
                              .add_jm()
                              .format(order.pickupDatetime.toDate()),
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.cube_box_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          order.pickUpPoint[0].address,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.location_solid,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          '${order.stopPoint.length} stops' ?? '0 stops',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.archivebox_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          order.dropOffPoint[0].address,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
