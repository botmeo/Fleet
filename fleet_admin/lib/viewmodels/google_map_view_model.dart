import 'dart:async';
import 'package:fleet_admin/models/directions.dart';
import 'package:fleet_admin/models/directions_point.dart';
import 'package:fleet_admin/models/orders.dart';
import 'package:fleet_admin/services/google_map_service.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class GoogleMapViewModel extends ChangeNotifier {
  final GoogleMapService mapService = GoogleMapService();
  Directions directions;
  List<Marker> markers = <Marker>[];
  List listWayPoints = [];
  String wayPoints = '';
  double totalMetersDistance = 0;
  double totalKilometersDistance = 0;
  String totalDistance = '';
  BitmapDescriptor markerTruck;
  BitmapDescriptor markerPickUp;
  BitmapDescriptor markerStop;
  LatLng latLngPosition;
  GoogleMapController googleMapController;

  Future<void> getDirections(DirectionPoint directionPoint) async {
    directions = await mapService.getDirections(directionPoint, wayPoints);
    for (var i = 0; i < directions.routes[0].legs.length; i++) {
      totalMetersDistance += directions.routes[0].legs[i].distance.value;
      totalKilometersDistance = (totalMetersDistance / 1000);
    }
    NumberFormat formatter = NumberFormat("#.##", "en_EN");
    totalDistance = formatter.format(totalKilometersDistance);
    notifyListeners();
  }

  void setTruckMarker() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/png/marker-truck.png',
    ).then((icon) {
      markerTruck = icon;
      notifyListeners();
    });
  }

  void setPickUpMarker() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/png/marker-pickup.png',
    ).then((icon) {
      markerPickUp = icon;
      notifyListeners();
    });
  }

  void setStopMarker() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/png/marker-stop.png',
    ).then((icon) {
      markerStop = icon;
      notifyListeners();
    });
  }

  void setCustomMarker() {
    setPickUpMarker();
    setStopMarker();
    setTruckMarker();
    notifyListeners();
  }

  void addPickUpMarker(String startName, double lat, double lng) {
    markers.add(
      Marker(
        markerId: const MarkerId('Pick up'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: startName,
        ),
        icon: markerPickUp,
      ),
    );
    notifyListeners();
  }

  void addDropOffMarker(String endName, double lat, double lng) {
    markers.add(
      Marker(
        markerId: const MarkerId('Drop off'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: endName,
        ),
        icon: markerStop,
      ),
    );
    notifyListeners();
  }

  void addStopMarker(int length, List<StopPoint> stopPoint) {
    for (int i = 0; i < length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(
            stopPoint[i].position.toString(),
          ),
          position: LatLng(
            stopPoint[i].lat,
            stopPoint[i].lng,
          ),
          infoWindow: InfoWindow(
            title: stopPoint[i].address,
          ),
          icon: markerStop,
        ),
      );
    }
    notifyListeners();
  }

  void addWayPoints(int length, List<StopPoint> stopPoint) {
    for (int i = 0; i < length; i++) {
      listWayPoints.add(stopPoint[i].lat);
      listWayPoints.add(stopPoint[i].lng);
    }
    for (var i = 0; i < listWayPoints.length; i++) {
      wayPoints += "${listWayPoints[i]}${(i + 1) % 2 == 0 ? " | " : ", "}";
    }
    wayPoints = wayPoints.substring(0, wayPoints.length - 1);
    notifyListeners();
  }

  void clearMaps() {
    markers.clear();
    listWayPoints.clear();
    wayPoints = '';
    totalMetersDistance = 0;
    totalKilometersDistance = 0;
    totalDistance = '';
    notifyListeners();
  }

  void updateTruckLatLng(LatLng latLng) {
    latLngPosition = latLng;
    notifyListeners();
  }

  Future<void> changeCameraFollowTruck(GoogleMapController controller) async {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLngPosition,
          zoom: 16.5,
        ),
      ),
    );
    notifyListeners();
  }
}
