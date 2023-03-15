import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleet_customer/models/trucks.dart';

class TruckService {
  Stream<List<Trucks>> getListTrucksFree(int lower, int upper) {
    return FirebaseFirestore.instance
        .collection('Trucks')
        .where('Status', isEqualTo: 'Free')
        .where('Capacity', isGreaterThanOrEqualTo: lower)
        .where('Capacity', isLessThanOrEqualTo: upper)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Trucks.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }
}
