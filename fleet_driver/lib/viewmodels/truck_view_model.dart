import 'package:fleet_driver/models/trucks.dart';
import 'package:fleet_driver/services/truck_service.dart';
import 'package:flutter/cupertino.dart';

class TruckViewModel extends ChangeNotifier {
  final TruckService truckService = TruckService();

  Stream<List<Trucks>> get infoTruck {
    return truckService.getTruck();
  }

  Future<void> updateTruckLocation(Trucks truck) async {
    await truckService.updateTruckLocation(truck);
    notifyListeners();
  }
}
