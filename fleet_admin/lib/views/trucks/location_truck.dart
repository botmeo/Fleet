import 'package:fleet_admin/models/trucks.dart';
import 'package:fleet_admin/viewmodels/google_map_view_model.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:provider/provider.dart';

class LocationTruck extends StatefulWidget {
  const LocationTruck({Key key}) : super(key: key);

  @override
  State<LocationTruck> createState() => _LocationTruckState();
}

class _LocationTruckState extends State<LocationTruck> {
  BitmapDescriptor markerTruck = BitmapDescriptor.defaultMarker;
  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/png/marker-truck.png",
    ).then((icon) {
      markerTruck = icon;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
  }

  @override
  void dispose() {
    setCustomMarker();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trucksViewModel = Provider.of<TruckViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Location truck',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: StreamBuilder<List<Trucks>>(
        stream: trucksViewModel.truckWithId,
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
          final truck = data[0];
          mapViewModel.updateTruckLatLng(LatLng(
            truck.currentLat,
            truck.currentLng,
          ));
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(truck.currentLat, truck.currentLng),
              zoom: 14.5,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            markers: {
              Marker(
                icon: markerTruck,
                markerId: const MarkerId('Id'),
                position: LatLng(truck.currentLat, truck.currentLng),
                infoWindow: InfoWindow(
                  title: truck.licensePlate,
                ),
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              mapViewModel.googleMapController = controller;
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          mapViewModel.changeCameraFollowTruck(
            mapViewModel.googleMapController,
          );
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          Icons.center_focus_strong,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
