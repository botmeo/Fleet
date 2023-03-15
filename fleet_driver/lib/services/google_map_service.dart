import 'package:fleet_driver/models/directions.dart';
import 'package:fleet_driver/models/directions_point.dart';
import 'package:fleet_driver/services/network_utility.dart';
import 'package:fleet_driver/utils/constants.dart';

class GoogleMapService {
  Future<Directions> getDirections(
    DirectionPoint directionPoint,
    String wayPoints,
  ) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/directions/json',
      {
        'origin': '${directionPoint.startLat},${directionPoint.startLng}',
        'destination': '${directionPoint.endLat},${directionPoint.endLng}',
        'waypoints': wayPoints,
        'language': 'vi',
        'key': apiKey,
      },
    );

    String response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      return Directions.parseDirectionsResult(response);
    } else {
      return null;
    }
  }
}
