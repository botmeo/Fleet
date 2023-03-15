import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleet_customer/models/customers.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(String uid, Customers customer) async {
    await firestore.collection('Customers').doc(uid).set({
      'Name': customer.name,
      'Phone': customer.phone,
      'Email': customer.email,
      'Balance': 0,
    });
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    Customers customer,
    context,
  ) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        User user = FirebaseAuth.instance.currentUser;
        createUser(user.uid, customer);
      });
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await firebaseAuth.currentUser.updatePassword(newPassword);
      firebaseAuth.signOut();
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      return error.toString();
    }
  }
}
