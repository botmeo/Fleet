import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CancelOrderDetailsScreen extends StatelessWidget {
  const CancelOrderDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        mapViewModel.clearMaps();
        return true;
      },
      child: Scaffold(
        body: StreamBuilder<List<Orders>>(
          stream: ordersProvider.orderWithId,
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
            final order = data[0];
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      order.pickUpPoint[0].lat,
                      order.pickUpPoint[0].lng,
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
                        points: mapViewModel
                            .directions.routes[0].overviewPolyline
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
                            color: AppColors.backgroundColor,
                            padding: const EdgeInsets.fromLTRB(18, 5, 18, 15),
                            child: RichText(
                              text: TextSpan(
                                text: 'Your order is ',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFonts.fontsPrimary,
                                  fontWeight: AppFonts.boldFonts,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'cancel',
                                    style: const TextStyle(
                                      color: AppColors.errorColor,
                                      fontFamily: AppFonts.fontsPrimary,
                                      fontWeight: AppFonts.boldFonts,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
                            child: Text(
                              '${order.stopPoint.length + 1} delivery points - ${order.itemDetails} - ${order.totalDistance} km',
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
                              order.pickUpPoint[0].address,
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
                                  order.pickUpPoint[0].description ??
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
                                  '${order.pickUpPoint[0].name} | ${order.pickUpPoint[0].phone}',
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
                            itemCount: order.stopPoint.length,
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
                                      order.stopPoint[index].address,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.stopPoint[index].description ??
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
                                          '${order.stopPoint[index].name} | ${order.stopPoint[index].phone}',
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
                              order.dropOffPoint[0].address,
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
                                  order.dropOffPoint[0].description ??
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
                                  '${order.dropOffPoint[0].name} | ${order.dropOffPoint[0].phone}',
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
            );
          },
        ),
      ),
    );
  }
}
