import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_driver/models/user.dart';

class UserService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<DriverUser>> getProfile() {
    return FirebaseFirestore.instance
        .collection('Drivers')
        .where(FieldPath.documentId, isEqualTo: firebaseAuth.currentUser.uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => DriverUser.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Future<void> updateProfile(DriverUser user) async {
    await firestore
        .collection('Drivers')
        .doc(firebaseAuth.currentUser.uid)
        .update({
      'Name': user.name,
      'Birthday': user.birthday,
      'Phone': user.phone,
    });
  }
}
