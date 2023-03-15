import 'package:fleet_driver/models/orders.dart';
import 'package:fleet_driver/models/statistical_data.dart';
import 'package:fleet_driver/services/order_service.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService orderService = OrderService();
  String idOrder = '';
  int completeOrdersCount = 0;
  int canceledOrdersCount = 0;
  List<StatisticalData> ordersWithItemDetails = [];
  List<StatisticalData> kmLast7Day = [];
  List<StatisticalData> ordersLast7Day = [];

  Stream<List<Orders>> get pendingOrdersToday {
    return orderService.getPendingOrdersToday();
  }

  Stream<List<Orders>> get historyCompleteOrders {
    return orderService.getOrders('Complete');
  }

  Stream<List<Orders>> get historyCancelOrders {
    return orderService.getOrders('Cancel');
  }

  Stream<List<Orders>> get orderWithId {
    return orderService.getOrderWithId(idOrder);
  }

  Future<void> sumKmLast7Days() async {
    kmLast7Day = await orderService.getKmComplete();
    notifyListeners();
  }

  Future<void> countOrdersLast7Days() async {
    ordersLast7Day = await orderService.getOrdersLast7Days();
    notifyListeners();
  }

  Future<void> countCompleteOrders() async {
    completeOrdersCount = await orderService.countOrdersWithStatus('Complete');
    notifyListeners();
  }

  Future<void> countCancelOrders() async {
    canceledOrdersCount = await orderService.countOrdersWithStatus('Cancel');
    notifyListeners();
  }

  Future<void> countOrdersWithItemDetails() async {
    ordersWithItemDetails = await orderService.countOrdersWithItemDetails();
    notifyListeners();
  }

  Future<void> statusOrderOngoing(String id) async {
    await orderService.changeStatusOrder(id, 'On going');
    notifyListeners();
  }

  Future<void> statusOrderComplete(String id) async {
    await orderService.changeStatusOrder(id, 'Complete');
    notifyListeners();
  }

  Future<void> statusOrderCancel(String id) async {
    await orderService.changeStatusOrder(id, 'Cancel');
    notifyListeners();
  }

  void updateIdOrder(String value) {
    idOrder = value;
    notifyListeners();
  }
}
