import 'package:fleet_admin/models/trucks.dart';
import 'package:fleet_admin/services/truck_service.dart';
import 'package:flutter/cupertino.dart';

class TruckViewModel extends ChangeNotifier {
  final TruckService truckService = TruckService();
  String idTruck = '';
  String query = '';
  int value;
  int trucksCount = 0;

  Stream<List<Trucks>> get listTrucks {
    return truckService.getListTrucks();
  }

  Stream<List<Trucks>> get truckWithId {
    return truckService.getTruckWithId(idTruck);
  }

  Stream<List<Trucks>> get listTrucksNoneUsed {
    return truckService.getListTrucksNoneUsed();
  }

  Future<void> addTruck(Trucks truck) async {
    await truckService.addTruck(truck);
    notifyListeners();
  }

  Future<void> updateTruck(Trucks truck) async {
    await truckService.updateTruck(truck);
    notifyListeners();
  }

  Future<void> updateTruckDriver(Trucks truck) async {
    await truckService.updateTruckDriver(truck, idTruck);
    notifyListeners();
  }

  Future<void> deleteTruck(String id) async {
    await truckService.deleteTruck(id);
    notifyListeners();
  }

  Stream<List<Trucks>> searchTruck(String query) {
    return truckService.searchTruck(query);
  }

  Future<void> countTrucks() async {
    trucksCount = await truckService.countTrucks();
    notifyListeners();
  }

  void updateValue(int ind, String id) {
    value = ind;
    idTruck = id;
    notifyListeners();
  }

  void updateValueQuery(String value) {
    query = value;
    notifyListeners();
  }

  void updateIdTruck(String value) {
    idTruck = value;
    // notifyListeners();
  }
}
