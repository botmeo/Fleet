import 'package:fleet_customer/models/directions.dart';
import 'package:fleet_customer/models/directions_point.dart';
import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/models/place_autocomplete.dart';
import 'package:fleet_customer/models/place_details.dart';
import 'package:fleet_customer/services/google_map_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class GoogleMapViewModel extends ChangeNotifier {
  final GoogleMapService mapService = GoogleMapService();
  PlaceAutoComplete placeAutoComplete;
  PlaceDetails placeDetails;
  Directions directions = null;
  List<Marker> listMarkers = <Marker>[];
  List listWayPoints = [];
  String wayPoints = '';
  double totalMetersDistance = 0;
  double totalKilometersDistance = 0;
  String totalDistance = '';
  BitmapDescriptor markerPickUp;
  BitmapDescriptor listMarkerstop;

  Future<void> searchPlaceAutoComplete(String query) async {
    placeAutoComplete = await mapService.searchPlaceAutoComplete(query);
    notifyListeners();
  }

  Future<void> getPlaceDetails(String query) async {
    placeDetails = await mapService.getDetailsPlace(query);
    notifyListeners();
  }

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

  void setCustomMarker() {
    setPickUpMarker();
    setStopMarker();
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
      listMarkerstop = icon;
      notifyListeners();
    });
  }

  void addPickUpMarker(String startName, double lat, double lng) {
    listMarkers.add(
      Marker(
        markerId: const MarkerId('Pick up'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: startName,
        ),
        icon: markerPickUp,
      ),
    );
  }

  void addDropOffMarker(String endName, double lat, double lng) {
    listMarkers.add(
      Marker(
        markerId: const MarkerId('Drop off'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: endName,
        ),
        icon: listMarkerstop,
      ),
    );
    notifyListeners();
  }

  void addStopMarker(int length, List<StopPoint> stopPoint) {
    for (int i = 0; i < length; i++) {
      listMarkers.add(
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
          icon: listMarkerstop,
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
    listMarkers.clear();
    listWayPoints.clear();
    wayPoints = '';
    totalMetersDistance = 0;
    totalKilometersDistance = 0;
    totalDistance = '';
    notifyListeners();
  }
}
