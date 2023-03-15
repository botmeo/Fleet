import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_admin/models/trucks.dart';

class TruckService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Trucks>> getListTrucks() {
    return firestore.collection('Trucks').snapshots().map((event) => event.docs
        .map(
          (document) => Trucks.fromJson(
            document.data(),
            document.id,
          ),
        )
        .toList());
  }

  Stream<List<Trucks>> getTruckWithId(String id) {
    return firestore
        .collection('Trucks')
        .where(FieldPath.documentId, isEqualTo: id)
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

  Stream<List<Trucks>> getListTrucksNoneUsed() {
    return firestore
        .collection('Trucks')
        .where('Used', isEqualTo: 'None')
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

  Future<void> addTruck(Trucks truck) async {
    await firestore.collection('Trucks').add({
      'LicensePlate': truck.licensePlate,
      'Model': truck.model,
      'Year': truck.year,
      'Manufacture': truck.manufacture,
      'Capacity': truck.capacity,
      'Cost': truck.cost,
      'Status': 'Free',
      'Used': 'None',
      'CurrentLat': 21.036715051,
      'CurrentLng': 105.804780033,
    });
  }

  Future<void> updateTruck(Trucks truck) async {
    await firestore.collection('Trucks').doc(truck.id).update({
      'LicensePlate': truck.licensePlate,
      'Model': truck.model,
      'Year': truck.year,
      'Manufacture': truck.manufacture,
      'Capacity': truck.capacity,
      'Cost': truck.cost,
    });
  }

  Future<void> updateTruckDriver(Trucks truck, String idTruck) async {
    await firestore.collection('Trucks').doc(idTruck).update({
      'Used': truck.used,
    });
  }

  Future<void> deleteTruck(String id) async {
    await firestore.collection('Trucks').doc(id).delete();
  }

  Stream<List<Trucks>> searchTruck(String query) {
    return firestore
        .collection('Trucks')
        .where('LicensePlate', isEqualTo: query)
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

  Future<int> countTrucks() async {
    QuerySnapshot snapshot = await firestore.collection('Trucks').get();
    return snapshot.docs.length;
  }
}
