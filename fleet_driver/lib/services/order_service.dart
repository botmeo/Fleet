import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_driver/models/orders.dart';
import 'package:fleet_driver/models/statistical_data.dart';
import 'package:intl/intl.dart';

class OrderService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();

  Stream<List<Orders>> getPendingOrdersToday() {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
        .where('Status', isEqualTo: 'Pending')
        .where(
          'PickUpDatetime',
          isGreaterThanOrEqualTo: DateTime(
            now.year,
            now.month,
            now.day,
          ),
        )
        .where(
          'PickUpDatetime',
          isLessThanOrEqualTo: DateTime(
            now.year,
            now.month,
            now.day + 1,
          ),
        )
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
    return FirebaseFirestore.instance
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

  Stream<List<Orders>> getOrders(String value) {
    return FirebaseFirestore.instance
        .collection('Orders')
        .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
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

  Future<List<StatisticalData>> getKmComplete() async {
    double total = 0;
    DateFormat formatter = DateFormat.E('en_US');
    List<StatisticalData> statisticalDataList = [];
    for (int i = 6; i >= 0; i--) {
      DateTime startOfDay = DateTime.now().subtract(Duration(days: i));
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
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

  Future<List<StatisticalData>> getOrdersLast7Days() async {
    DateFormat formatter = DateFormat.E('en_US');
    List<StatisticalData> statisticalDataList = [];
    for (int i = 6; i >= 0; i--) {
      DateTime startOfDay = DateTime.now().subtract(Duration(days: i));
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));
      QuerySnapshot snapshot = await firestore
          .collection('Orders')
          .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
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

  Future<int> countOrdersWithStatus(String value) async {
    QuerySnapshot snapshot = await firestore
        .collection('Orders')
        .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
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
          .where('IdDriver', isEqualTo: firebaseAuth.currentUser.uid)
          .where('Status', isEqualTo: 'Complete')
          .where('ItemDetails', isEqualTo: itemDetail)
          .get();
      int count = snapshot.docs.length;
      statisticalDataList.add(StatisticalData(itemDetail, count));
    }
    return statisticalDataList;
  }

  Future<void> changeStatusOrder(String id, String value) async {
    await firestore.collection('Orders').doc(id).update({
      'Status': value,
    });
  }
}
