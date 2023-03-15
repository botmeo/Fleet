import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/models/statistical_data.dart';
import 'package:intl/intl.dart';

class OrderService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<List<Orders>> getOrders(String value) {
    return firestore
        .collection('Orders')
        .where('IdCustomer', isEqualTo: firebaseAuth.currentUser.uid)
        .where('Status', isEqualTo: value)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Orders.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Stream<List<Orders>> getOrderWithId(String id) {
    return firestore
        .collection('Orders')
        .where(FieldPath.documentId, isEqualTo: id)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Orders.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Future<int> countOrdersWithStatus(String value) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .where('IdCustomer', isEqualTo: firebaseAuth.currentUser.uid)
        .where('Status', isEqualTo: value)
        .get();
    return snapshot.docs.length;
  }

  Future<List<StatisticalData>> countOrdersWithItemDetails() async {
    List<StatisticalData> statisticalDataList = [];
    List<String> itemDetails = [
      'Comestic',
      'Pharma',
      'Food',
      'Equipment',
      'Other',
    ];

    for (var itemDetail in itemDetails) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('IdCustomer', isEqualTo: firebaseAuth.currentUser.uid)
          .where('Status', isEqualTo: 'Complete')
          .where('ItemDetails', isEqualTo: itemDetail)
          .get();
      int count = snapshot.docs.length;
      statisticalDataList.add(StatisticalData(itemDetail, count));
    }
    return statisticalDataList;
  }

  Future<List<StatisticalData>> countOrdersWithItemDetailsAndStatus(
      String value) async {
    List<StatisticalData> statisticalDataList = [];
    List<String> itemDetails = [
      'Comestic',
      'Pharma',
      'Food',
      'Equipment',
      'Other',
    ];

    for (var itemDetail in itemDetails) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('IdCustomer', isEqualTo: firebaseAuth.currentUser.uid)
          .where('Status', isEqualTo: value)
          .where('ItemDetails', isEqualTo: itemDetail)
          .get();
      int count = snapshot.docs.length;
      statisticalDataList.add(StatisticalData(itemDetail, count));
    }
    return statisticalDataList;
  }

  Future<List<StatisticalData>> getOrdersLast7Days() async {
    DateFormat formatter = DateFormat.E('en_US');
    List<StatisticalData> statisticalDataList = [];
    for (int i = 6; i >= 0; i--) {
      DateTime startOfDay = DateTime.now().subtract(Duration(days: i));
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('IdCustomer', isEqualTo: firebaseAuth.currentUser.uid)
          .where('Status', isEqualTo: 'Complete')
          .where(
            'PickUpDatetime',
            isGreaterThanOrEqualTo: startOfDay,
          )
          .where(
            'PickUpDatetime',
            isLessThanOrEqualTo: endOfDay,
          )
          .get();
      int count = snapshot.docs.length;
      statisticalDataList
          .add(StatisticalData(formatter.format(startOfDay), count));
    }
    return statisticalDataList;
  }

  Future<void> createOrder(
    List<Orders> listOrders,
    List<PickUpPoint> listPickUpPoint,
    List<StopPoint> listStopPoints,
    List<DropOffPoint> listDropOffPoint,
  ) async {
    List<Map<String, dynamic>> pickUpPointMaps = [];
    for (PickUpPoint pickUpPoint in listPickUpPoint) {
      pickUpPointMaps.add(pickUpPoint.toJson());
    }
    List<Map<String, dynamic>> stopPointMaps = [];
    for (StopPoint stopPoint in listStopPoints) {
      stopPointMaps.add(stopPoint.toJson());
    }
    List<Map<String, dynamic>> dropOffPointMaps = [];
    for (DropOffPoint dropOffPoint in listDropOffPoint) {
      dropOffPointMaps.add(dropOffPoint.toJson());
    }
    await firestore.collection('Orders').add({
      'IdCustomer': firebaseAuth.currentUser.uid,
      'IdTruck': listOrders[0].idTruck,
      'IdDriver': listOrders[0].idDriver,
      'PickUpPoint': pickUpPointMaps,
      'StopPoint': stopPointMaps,
      'DropOffPoint': dropOffPointMaps,
      'Demand': listOrders[0].demand,
      'ItemDetails': listOrders[0].itemDetails,
      'Note': listOrders[0].note,
      'Optimize': listOrders[0].optimize,
      'TotalPayment': listOrders[0].totalPayment,
      'TotalDistance': listOrders[0].totalDistance,
      'PickUpDatetime': listOrders[0].pickupDatetime,
      'Status': 'Pending',
    });
  }
}
