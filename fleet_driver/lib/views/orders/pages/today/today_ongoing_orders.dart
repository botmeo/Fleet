import 'package:fleet_driver/models/orders.dart';
import 'package:fleet_driver/models/trucks.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/viewmodels/google_map_view_model.dart';
import 'package:fleet_driver/viewmodels/order_view_model.dart';
import 'package:fleet_driver/viewmodels/truck_view_model.dart';
import 'package:fleet_driver/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TodayOngoingScreen extends StatefulWidget {
  const TodayOngoingScreen({Key key}) : super(key: key);

  @override
  State<TodayOngoingScreen> createState() => _TodayOngoingScreenState();
}

class _TodayOngoingScreenState extends State<TodayOngoingScreen> {

  
  @override
  void didChangeDependencies() {
    Provider.of<GoogleMapViewModel>(context).getCurrentLocation();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersViewModel = Provider.of<OrderViewModel>(context);
    final trucksViewModel = Provider.of<TruckViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: StreamBuilder<List<Orders>>(
          stream: ordersViewModel.orderWithId,
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
            if (mapViewModel.currentLocation != null) {
              trucksViewModel.updateTruckLocation(
                Trucks(
                  id: order.idTruck,
                  currentLat: mapViewModel.currentLocation.latitude,
                  currentLng: mapViewModel.currentLocation.longitude,
                ),
              );
            }
            return Stack(
              children: [
                mapViewModel.currentLocation == null
                    ? const Center(child: ColorLoader())
                    : GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            mapViewModel.currentLocation.latitude,
                            mapViewModel.currentLocation.longitude,
                          ),
                          zoom: 14.5,
                        ),
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        markers: {
                          Marker(
                            markerId: const MarkerId('Me'),
                            position: LatLng(
                              mapViewModel.currentLocation.latitude,
                              mapViewModel.currentLocation.longitude,
                            ),
                            infoWindow: const InfoWindow(
                              title: 'Me',
                            ),
                            icon: mapViewModel.markerTruck,
                          ),
                          Marker(
                            markerId: const MarkerId('Pick up'),
                            position: LatLng(
                              order.pickUpPoint[0].lat,
                              order.pickUpPoint[0].lng,
                            ),
                            infoWindow: InfoWindow(
                              title: order.pickUpPoint[0].address,
                            ),
                            icon: mapViewModel.markerPickUp,
                          ),
                          Marker(
                            markerId: const MarkerId('Drop off'),
                            position: LatLng(
                              order.dropOffPoint[0].lat,
                              order.dropOffPoint[0].lng,
                            ),
                            infoWindow: InfoWindow(
                              title: order.dropOffPoint[0].address,
                            ),
                            icon: mapViewModel.markerStop,
                          ),
                          if (order.stopPoint.isNotEmpty)
                            for (int i = 0; i < order.stopPoint.length; i++)
                              Marker(
                                markerId: MarkerId(
                                  order.stopPoint[i].position.toString(),
                                ),
                                position: LatLng(
                                  order.stopPoint[i].lat,
                                  order.stopPoint[i].lng,
                                ),
                                infoWindow: InfoWindow(
                                  title: order.stopPoint[i].address,
                                ),
                                icon: mapViewModel.markerStop,
                              ),
                        },
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
                        onMapCreated: (mapController) {
                          mapViewModel.controllerCompleter
                              .complete(mapController);
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
                            onTap: () {
                              FlutterPhoneDirectCaller.callNumber(
                                order.pickUpPoint[0].phone,
                              );
                            },
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
                                    onTap: () {
                                      FlutterPhoneDirectCaller.callNumber(
                                        order.stopPoint[index].phone,
                                      );
                                    },
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
                            onTap: () {
                              FlutterPhoneDirectCaller.callNumber(
                                order.dropOffPoint[0].phone,
                              );
                            },
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
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: const EdgeInsets.all(15),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ordersViewModel.statusOrderComplete(ordersViewModel.idOrder);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.updateColor,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Complete',
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.boldFonts,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
