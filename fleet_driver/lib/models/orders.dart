import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String id;
  String idCustomer;
  String idTruck;
  String idDriver;
  List<PickUpPoint> pickUpPoint;
  List<StopPoint> stopPoint;
  List<DropOffPoint> dropOffPoint;
  String demand;
  String itemDetails;
  String note;
  String status;
  double totalDistance;
  Timestamp pickupDatetime;
  Timestamp deliveryDatetime;

  Orders({
    this.id,
    this.idCustomer,
    this.idTruck,
    this.idDriver,
    this.pickUpPoint,
    this.stopPoint,
    this.dropOffPoint,
    this.demand,
    this.itemDetails,
    this.note,
    this.status,
    this.totalDistance,
    this.pickupDatetime,
    this.deliveryDatetime,
  });

  Orders.fromJson(Map<String, dynamic> json, String idOrder) {
    id = idOrder;
    idCustomer = json['IdCustomer'];
    idTruck = json['IdTruck'];
    idDriver = json['IdDriver'];
    if (json['PickUpPoint'] != null) {
      pickUpPoint = <PickUpPoint>[];
      json['PickUpPoint'].forEach((v) {
        pickUpPoint.add(PickUpPoint.fromJson(v));
      });
    }
    if (json['StopPoint'] != null) {
      stopPoint = <StopPoint>[];
      json['StopPoint'].forEach((v) {
        stopPoint.add(StopPoint.fromJson(v));
      });
    }
    if (json['DropOffPoint'] != null) {
      dropOffPoint = <DropOffPoint>[];
      json['DropOffPoint'].forEach((v) {
        dropOffPoint.add(DropOffPoint.fromJson(v));
      });
    }
    demand = json['Demand'];
    itemDetails = json['ItemDetails'];
    note = json['Note'];
    status = json['Status'];
    totalDistance = json['TotalDistance'];
    pickupDatetime = json['PickUpDatetime'];
    deliveryDatetime = json['DeliveryDatetime'];
  }
}

class PickUpPoint {
  String address;
  String description;
  String name;
  String phone;
  double lat;
  double lng;

  PickUpPoint({
    this.address,
    this.description,
    this.name,
    this.phone,
    this.lat,
    this.lng,
  });

  factory PickUpPoint.fromJson(Map<String, dynamic> json) {
    return PickUpPoint(
      address: json['Address'],
      description: json['Description'],
      name: json['Name'],
      phone: json['Phone'],
      lat: json['Lat'],
      lng: json['Lng'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Phone': phone,
        'Address': address,
        'Description': description,
        'Lat': lat,
        'Lng': lng,
      };
}

class StopPoint {
  int position;
  String address;
  String description;
  String name;
  String phone;
  double lat;
  double lng;

  StopPoint({
    this.position,
    this.address,
    this.description,
    this.name,
    this.phone,
    this.lat,
    this.lng,
  });

  factory StopPoint.fromJson(Map<String, dynamic> json) {
    return StopPoint(
      address: json['Address'],
      description: json['Description'],
      name: json['Name'],
      phone: json['Phone'],
      lat: json['Lat'],
      lng: json['Lng'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Position': position,
        'Address': address,
        'Description': description,
        'Name': name,
        'Phone': phone,
        'Lat': lat,
        'Lng': lng,
      };
}

class DropOffPoint {
  String address;
  String description;
  String name;
  String phone;
  double lat;
  double lng;

  DropOffPoint({
    this.address,
    this.description,
    this.name,
    this.phone,
    this.lat,
    this.lng,
  });

  factory DropOffPoint.fromJson(Map<String, dynamic> json) {
    return DropOffPoint(
      address: json['Address'],
      description: json['Description'],
      name: json['Name'],
      phone: json['Phone'],
      lat: json['Lat'],
      lng: json['Lng'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Phone': phone,
        'Address': address,
        'Description': description,
        'Lat': lat,
        'Lng': lng,
      };
}
