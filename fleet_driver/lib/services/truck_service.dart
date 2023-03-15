import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_driver/models/trucks.dart';

class TruckService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Trucks>> getTruck() {
    return firestore
        .collection('Trucks')
        .where('Used', isEqualTo: firebaseAuth.currentUser.uid)
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

  Future<void> updateTruckLocation(Trucks truck) async {
    await firestore.collection('Trucks').doc(truck.id).update({
      'CurrentLat': truck.currentLat,
      'CurrentLng': truck.currentLng,
    });
  }
}
