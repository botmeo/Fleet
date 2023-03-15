import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_admin/models/orders.dart';
import 'package:fleet_admin/models/statistical_data.dart';
import 'package:intl/intl.dart';

class OrderService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  Stream<List<Orders>> getOrders(String value) {
    return firestore
        .collection('Orders')
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

  Future<int> countOrdersWithStatus(String value) async {
    QuerySnapshot snapshot = await firestore
        .collection('Orders')
        .where('Status', isEqualTo: value)
        .get();
    return snapshot.docs.length;
  }

  Future<int> countOrdersDriverWithStatus(String id, String value) async {
    QuerySnapshot snapshot = await firestore
        .collection('Orders')
        .where('IdDriver', isEqualTo: id)
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
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('ItemDetails', isEqualTo: itemDetail)
          .get();
      int count = snapshot.docs.length;
      statisticalDataList.add(StatisticalData(itemDetail, count));
    }
    return statisticalDataList;
  }

  Future<List<StatisticalData>> countOrdersWithOptimize() async {
    List<StatisticalData> statisticalDataList = [];
    List<bool> booleanValue = [
      true,
      false,
    ];

    for (var boolean in booleanValue) {
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('Optimize', isEqualTo: boolean)
          .get();
      int count = snapshot.docs.length;
      statisticalDataList.add(StatisticalData(boolean, count));
    }
    return statisticalDataList;
  }

  Future<List<StatisticalData>> getKmComplete(String id) async {
    double total = 0;
    DateFormat formatter = DateFormat.E('en_US');
    List<StatisticalData> statisticalDataList = [];
    for (int i = 6; i >= 0; i--) {
      DateTime startOfDay = DateTime.now().subtract(Duration(days: i));
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('IdDriver', isEqualTo: id)
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

      for (DocumentSnapshot doc in snapshot.docs) {
        total += doc.get('TotalDistance');
      }
      statisticalDataList
          .add(StatisticalData(formatter.format(startOfDay), total));
      total = 0;
    }
    return statisticalDataList;
  }

  Future<List<StatisticalData>> getOrdersLast7Days(String id) async {
    DateFormat formatter = DateFormat.E('en_US');
    List<StatisticalData> statisticalDataList = [];
    for (int i = 6; i >= 0; i--) {
      DateTime startOfDay = DateTime.now().subtract(Duration(days: i));
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('IdCustomer', isEqualTo: id)
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
}
