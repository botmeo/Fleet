import 'package:fleet_customer/models/directions.dart';
import 'package:fleet_customer/models/directions_point.dart';
import 'package:fleet_customer/models/place_autocomplete.dart';
import 'package:fleet_customer/models/place_details.dart';
import 'package:fleet_customer/services/network_utility.dart';
import 'package:fleet_customer/utils/constants.dart';

class GoogleMapService {
  Future<PlaceAutoComplete> searchPlaceAutoComplete(String query) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        'input': query,
        'key': apiKey,
      },
    );

    String response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      return PlaceAutoComplete.parseAutocompleteResult(response);
    } else {
      return null;
    }
  }

  Future<PlaceDetails> getDetailsPlace(String query) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/details/json',
      {
        'place_id': query,
        'language': 'vi',
        'key': apiKey,
      },
    );

    String response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      return PlaceDetails.parsePlaceDetailsResult(response);
    } else {
      return null;
    }
  }

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
