import 'package:fleet_customer/models/trucks.dart';
import 'package:fleet_customer/services/truck_service.dart';
import 'package:flutter/cupertino.dart';

class TruckViewModel extends ChangeNotifier {
  final TruckService truckService = TruckService();
  int value;

  Stream<List<Trucks>> listTruckFree(int lower, int upper) {
    return truckService.getListTrucksFree(lower, upper);
  }

  void updateValue(int ind) {
    value = ind;
    notifyListeners();
  }
}
