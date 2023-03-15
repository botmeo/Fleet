import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  List<Routes> routes;

  Directions({
    this.routes,
  });

  Directions.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes.add(Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'routes': routes.map((v) => v.toJson()).toList(),
      };

  static Directions parseDirectionsResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return Directions.fromJson(parsed);
  }
}

class Routes {
  Bounds bounds;
  String copyrights;
  List<Legs> legs;
  Polyline overviewPolyline;
  String summary;
  // List<dynamic> warnings;
  List<int> waypointOrder;

  Routes({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    // this.warnings,
    this.waypointOrder,
  });

  Routes.fromJson(Map<String, dynamic> json) {
    bounds = json['bounds'] != null ? Bounds.fromJson(json['bounds']) : null;
    copyrights = json['copyrights'];
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs.add(Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ? Polyline.fromJson(json['overview_polyline'])
        : null;
    summary = json['summary'];
    // if (json['warnings'] != null) {
    //   warnings = <Null>[];
    //   json['warnings'].forEach((v) {
    //     warnings.add(new dynamic.fromJson(v));
    //   });
    // }
    waypointOrder = json['waypoint_order'].cast<int>();
  }

  Map<String, dynamic> toJson() => {
        'bounds': bounds.toJson(),
        'copyrights': copyrights,
        'legs': legs.map((v) => v.toJson()).toList(),
        'overview_polyline': overviewPolyline.toJson(),
        'summary': summary,
        // 'warnings': warnings.map((v) => v.toJson()).toList(),
        'waypoint_order': waypointOrder,
      };
}

class Bounds {
  Northeast northeast;
  Northeast southwest;

  Bounds({
    this.northeast,
    this.southwest,
  });

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };
}

class Northeast {
  double lat;
  double lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class Legs {
  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Steps> steps;
  // List<dynamic> trafficSpeedEntry;
  // List<dynamic> viaWaypoint;

  Legs({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    // this.trafficSpeedEntry,
    // this.viaWaypoint,
  });

  Legs.fromJson(Map<String, dynamic> json) {
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration =
        json['duration'] != null ? Distance.fromJson(json['duration']) : null;
    endAddress = json['end_address'];
    endLocation = json['end_location'] != null
        ? Northeast.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    startLocation = json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps.add(Steps.fromJson(v));
      });
    }
    // if (json['traffic_speed_entry'] != null) {
    //   trafficSpeedEntry = <Null>[];
    //   json['traffic_speed_entry'].forEach((v) {
    //     trafficSpeedEntry.add( Null.fromJson(v));
    //   });
    // }
    // if (json['via_waypoint'] != null) {
    //   viaWaypoint = <Null>[];
    //   json['via_waypoint'].forEach((v) {
    //     viaWaypoint.add( Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'end_address': endAddress,
        'end_location': endLocation.toJson(),
        'start_address': startAddress,
        'start_location': startLocation.toJson(),
        'steps': steps.map((v) => v.toJson()).toList(),
        // 'traffic_speed_entry':
        //     trafficSpeedEntry.map((v) => v.toJson()).toList(),
        // 'via_waypoint': viaWaypoint.map((v) => v.toJson()).toList(),
      };
}

class Distance {
  String text;
  int value;

  Distance({
    this.text,
    this.value,
  });

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };
}

class Steps {
  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  Polyline polyline;
  Northeast startLocation;
  String travelMode;
  String maneuver;

  Steps({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
    this.maneuver,
  });

  Steps.fromJson(Map<String, dynamic> json) {
    distance =
        json['distance'] != null ? Distance.fromJson(json['distance']) : null;
    duration =
        json['duration'] != null ? Distance.fromJson(json['duration']) : null;
    endLocation = json['end_location'] != null
        ? Northeast.fromJson(json['end_location'])
        : null;
    htmlInstructions = json['html_instructions'];
    polyline =
        json['polyline'] != null ? Polyline.fromJson(json['polyline']) : null;
    startLocation = json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : null;
    travelMode = json['travel_mode'];
    maneuver = json['maneuver'];
  }

  Map<String, dynamic> toJson() => {
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'end_location': endLocation.toJson(),
        'html_instructions': htmlInstructions,
        'polyline': polyline.toJson(),
        'start_location': startLocation.toJson(),
        'travel_mode': travelMode,
        'maneuver': maneuver,
      };
}

class Polyline {
  String points;

  Polyline({
    this.points,
  });

  Polyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() => {
        'points': points,
      };

  List<LatLng> decodePolyline() {
    List decoded = PolylinePoints().decodePolyline(points);
    return decoded.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }
}
