import 'package:fleet_admin/models/orders.dart';
import 'package:fleet_admin/models/statistical_data.dart';
import 'package:fleet_admin/services/order_service.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService orderService = OrderService();
  String idOrder = '';
  int pendingOrdersCount = 0;
  int ongoingdOrdersCount = 0;
  int completeOrdersCount = 0;
  int cancelOrdersCount = 0;
  int pendingOrdersDriverCount = 0;
  int ongoingdOrdersDriverCount = 0;
  int completeOrdersDriverCount = 0;
  int cancelOrdersDriverCount = 0;
  List<StatisticalData> ordersWithItemDetails = [];
  List<StatisticalData> ordersWithOptimize = [];
  List<StatisticalData> kmLast7Day = [];
  List<StatisticalData> ordersLast7Day = [];
  int totalOrdersOptimize = 0;

  Stream<List<Orders>> get pendingOrders {
    return orderService.getOrders('Pending');
  }

  Stream<List<Orders>> get ongoingOrders {
    return orderService.getOrders('On going');
  }

  Stream<List<Orders>> get completeOrders {
    return orderService.getOrders('Complete');
  }

  Stream<List<Orders>> get cancelOrders {
    return orderService.getOrders('Cancel');
  }

  Stream<List<Orders>> get orderWithId {
    return orderService.getOrderWithId(idOrder);
  }

  Future<void> countPendingOrders() async {
    pendingOrdersCount = await orderService.countOrdersWithStatus('Pending');
    notifyListeners();
  }

  Future<void> countOngoingOrders() async {
    ongoingdOrdersCount = await orderService.countOrdersWithStatus('On going');
    notifyListeners();
  }

  Future<void> countCompleteOrders() async {
    completeOrdersCount = await orderService.countOrdersWithStatus('Complete');
    notifyListeners();
  }

  Future<void> countCancelOrders() async {
    cancelOrdersCount = await orderService.countOrdersWithStatus('Cancel');
    notifyListeners();
  }

  Future<void> countPendingOrdersDriver(String id) async {
    pendingOrdersDriverCount = await orderService.countOrdersDriverWithStatus(
      id,
      'Pending',
    );
    notifyListeners();
  }

  Future<void> countOngoingOrdersDriver(String id) async {
    ongoingdOrdersDriverCount = await orderService.countOrdersDriverWithStatus(
      id,
      'On going',
    );
    notifyListeners();
  }

  Future<void> countCompleteOrdersDriver(String id) async {
    completeOrdersDriverCount = await orderService.countOrdersDriverWithStatus(
      id,
      'Complete',
    );
    notifyListeners();
  }

  Future<void> countCancelOrdersDriver(String id) async {
    cancelOrdersDriverCount = await orderService.countOrdersDriverWithStatus(
      id,
      'Cancel',
    );
    notifyListeners();
  }

  Future<void> countOrdersWithItemDetails() async {
    ordersWithItemDetails = await orderService.countOrdersWithItemDetails();
    notifyListeners();
  }

  Future<void> countOrdersWithOptimize() async {
    ordersWithOptimize = await orderService.countOrdersWithOptimize();
    totalOrdersOptimize =
        ordersWithOptimize[0].amount + ordersWithOptimize[1].amount;
    notifyListeners();
  }

  Future<void> sumKmLast7Days(String id) async {
    kmLast7Day = await orderService.getKmComplete(id);
    notifyListeners();
  }

  Future<void> countOrdersLast7Days(String id) async {
    ordersLast7Day = await orderService.getOrdersLast7Days(id);
    notifyListeners();
  }

  // Future<void> statusOrderOngoing(String id) async {
  //   await orderService.changeStatusOrder(id, 'On going');
  //   notifyListeners();
  // }

  // Future<void> statusOrderComplete(String id) async {
  //   await orderService.changeStatusOrder(id, 'Complete');
  //   notifyListeners();
  // }

  // Future<void> statusOrderCancel(String id) async {
  //   await orderService.changeStatusOrder(id, 'Cancel');
  //   notifyListeners();
  // }

  void updateIdOrder(String value) {
    idOrder = value;
    notifyListeners();
  }
}
