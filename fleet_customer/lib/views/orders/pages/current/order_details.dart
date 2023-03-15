import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  orderViewModel.listPickUpPoint[0].lat,
                  orderViewModel.listPickUpPoint[0].lng,
                ),
                zoom: 12.5,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              markers: Set<Marker>.of(mapViewModel.listMarkers),
              polylines: {
                if (mapViewModel.directions != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: AppColors.secondaryColor,
                    width: 3,
                    points: mapViewModel.directions.routes[0].overviewPolyline
                        .decodePolyline()
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              snapSizes: const [0.3, 0.9],
              builder: (context, scrollController) {
                return Container(
                  color: AppColors.backgroundColor,
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
                        child: Text(
                          '${orderViewModel.listStopPointStandard.length + 1} delivery points - ${orderViewModel.listOrders[0].itemDetails} - ${orderViewModel.listOrders[0].totalDistance} km',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.cube_box_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          orderViewModel.listPickUpPoint[0].address,
                          maxLines: 2,
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
                              orderViewModel.listPickUpPoint[0].description ??
                                  'No information',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${orderViewModel.listPickUpPoint[0].name} | ${orderViewModel.listPickUpPoint[0].phone}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: orderViewModel.optimize == true
                            ? orderViewModel.listStopPointOptimize.length
                            : orderViewModel.listStopPointStandard.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  CupertinoIcons.location_solid,
                                  color: AppColors.secondaryColor,
                                ),
                                horizontalTitleGap: 0,
                                title: Text(
                                  orderViewModel.optimize == true
                                      ? orderViewModel
                                          .listStopPointOptimize[index].address
                                      : orderViewModel
                                          .listStopPointStandard[index].address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFonts.fontsPrimary,
                                    fontWeight: AppFonts.regularFonts,
                                    fontSize: 14,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderViewModel.optimize == true
                                          ? (orderViewModel
                                                  .listStopPointOptimize[index]
                                                  .description ??
                                              'No information')
                                          : (orderViewModel
                                                  .listStopPointStandard[index]
                                                  .description ??
                                              'No information'),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.subTextColor,
                                        fontFamily: AppFonts.fontsPrimary,
                                        fontWeight: AppFonts.regularFonts,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      orderViewModel.optimize == true
                                          ? ('${orderViewModel.listStopPointOptimize[index].name} | ${orderViewModel.listStopPointOptimize[index].phone}')
                                          : ('${orderViewModel.listStopPointStandard[index].name} | ${orderViewModel.listStopPointStandard[index].phone}'),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.subTextColor,
                                        fontFamily: AppFonts.fontsPrimary,
                                        fontWeight: AppFonts.regularFonts,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          CupertinoIcons.archivebox_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          orderViewModel.listDropOffPoint[0].address,
                          maxLines: 2,
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
                              orderViewModel.listDropOffPoint[0].description ??
                                  'No information',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.subTextColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${orderViewModel.listDropOffPoint[0].name} | ${orderViewModel.listDropOffPoint[0].phone}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.subTextColor,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
