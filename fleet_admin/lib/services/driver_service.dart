import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_admin/models/drivers.dart';

class DriverService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<List<Drivers>> getListDrivers() {
    return firestore.collection('Drivers').snapshots().map((event) => event.docs
        .map(
          (document) => Drivers.fromJson(
            document.data(),
            document.id,
          ),
        )
        .toList());
  }

  Stream<List<Drivers>> getDriverWithId(String id) {
    return firestore
        .collection('Drivers')
        .where(FieldPath.documentId, isEqualTo: id)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Drivers.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Future<void> createInfoDriver(String uid, Drivers driver) async {
    await firestore.collection('Drivers').doc(uid).set({
      'Name': driver.name,
      'Birthday': driver.birthday,
      'Phone': driver.phone,
      'Email': driver.email,
    });
  }

  Future<void> updateDriver(Drivers driver) async {
    await firestore.collection('Drivers').doc(driver.id).update({
      'Name': driver.name,
      'Birthday': driver.birthday,
      'Phone': driver.phone,
    });
  }

  Future<void> deleteDriver(String id) async {
    await firestore.collection('Drivers').doc(id).delete();
  }

  Stream<List<Drivers>> searchDriver(String query) {
    return firestore
        .collection('Drivers')
        .where('Phone', isEqualTo: query)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Drivers.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Future<int> countDrivers() async {
    QuerySnapshot snapshot = await firestore.collection('Drivers').get();
    return snapshot.docs.length;
  }
}
