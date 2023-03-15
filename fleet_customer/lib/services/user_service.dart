import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_customer/models/customers.dart';

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<List<Customers>> getInfoUser() {
    return FirebaseFirestore.instance
        .collection('Customers')
        .where(FieldPath.documentId, isEqualTo: firebaseAuth.currentUser.uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (document) => Customers.fromJson(
                document.data(),
                document.id,
              ),
            )
            .toList());
  }

  Future<void> updateProfile(Customers customers) async {
    await firestore
        .collection('Customers')
        .doc(firebaseAuth.currentUser.uid)
        .update({
      'Name': customers.name,
      'Phone': customers.phone,
    });
  }

  Future<double> getBalance() async {
    DocumentSnapshot snapshot = await firestore
        .collection('Customers')
        .doc(firebaseAuth.currentUser.uid)
        .get();
    return snapshot.get('Balance');
  }

  Future<void> changeBalanceAccount(double newBalance) async {
    await firestore
        .collection('Customers')
        .doc(firebaseAuth.currentUser.uid)
        .update({
      'Balance': newBalance,
    });
  }
}
