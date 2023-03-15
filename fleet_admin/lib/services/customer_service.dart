import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleet_admin/models/customers.dart';

class CustomerService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Customers>> getListCustomers() {
    return FirebaseFirestore.instance
        .collection('Customers')
        .snapshots()
        .map((event) => event.docs.map((document) {
              return Customers.fromJson(
                document.data(),
                document.id,
              );
            }).toList());
  }

  Stream<List<Customers>> getCustomerWithId(String id) {
    return firestore
        .collection('Customers')
        .where(FieldPath.documentId, isEqualTo: id)
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

  Stream<List<Customers>> searchCustomer(String query) {
    return FirebaseFirestore.instance
        .collection('Customers')
        .where('Phone', isEqualTo: query)
        .snapshots()
        .map((event) => event.docs.map((document) {
              return Customers.fromJson(
                document.data(),
                document.id,
              );
            }).toList());
  }

  Future<int> countCustomers() async {
    QuerySnapshot snapshot = await firestore.collection('Customers').get();
    return snapshot.docs.length;
  }
}
