import 'package:fleet_admin/models/customers.dart';
import 'package:fleet_admin/services/customer_service.dart';
import 'package:flutter/material.dart';

class CustomerViewModel extends ChangeNotifier {
  final CustomerService customerService = CustomerService();
  String idCustomer = '';
  String query = '';
  int customersCount = 0;

  Stream<List<Customers>> get listCustomers {
    return customerService.getListCustomers();
  }

  Stream<List<Customers>> get customerWithId {
    return customerService.getCustomerWithId(idCustomer);
  }

  Stream<List<Customers>> searchCustomer(String query) {
    return customerService.searchCustomer(query);
  }

  Future<void> countCustomers() async {
    customersCount = await customerService.countCustomers();
    notifyListeners();
  }

  void updateValueQuery(String value) {
    query = value;
    notifyListeners();
  }

  void updateIdCustomer(String value) {
    idCustomer = value;
    // notifyListeners();
  }
}
