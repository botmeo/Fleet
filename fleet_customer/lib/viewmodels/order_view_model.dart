import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/models/statistical_data.dart';
import 'package:fleet_customer/services/order_service.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderService orderService = OrderService();
  String idOrder = '';
  List<Orders> listOrders = [];
  List<PickUpPoint> listPickUpPoint = [];
  List<StopPoint> listStopPointStandard = [];
  List<StopPoint> listStopPointOptimize = [];
  List<DropOffPoint> listDropOffPoint = [];
  String pickUpAddress = 'Pick up location';
  String dropOffAddress = 'Drop off location';
  String dateTimeOrder = 'Pick up time';
  String subTextItemDetails = 'Describe the type of your item';
  String subTextDemand = 'Estimate the total weight of your items';
  String subTextNote = 'Important info the driver should know';
  bool optimize = false;
  int positionMidStop = 0;
  double totalPayment = 0;
  int lowerDemand;
  int upperDemand;
  int value;
  int pendingOrdersCount = 0;
  int ongoingOrdersCount = 0;
  int completeOrdersCount = 0;
  int canceledOrdersCount = 0;
  List<StatisticalData> ordersWithItemDetails = [];
  List<StatisticalData> ordersLast7Day = [];
  // List<StatisticalData> ordersPendingWithItemDetails = [];
  // List<StatisticalData> ordersOngoingWithItemDetails = [];
  // List<StatisticalData> ordersCompleteWithItemDetails = [];
  // List<StatisticalData> ordersCancelWithItemDetails = [];

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
    ongoingOrdersCount = await orderService.countOrdersWithStatus('On going');
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

  // Future<void> countPendingOrdersWithItemDetails() async {
  //   ordersPendingWithItemDetails =
  //       await orderService.countOrdersWithItemDetailsAndStatus('Pending');
  //   notifyListeners();
  // }

  // Future<void> countOngoingOrdersWithItemDetails() async {
  //   ordersOngoingWithItemDetails =
  //       await orderService.countOrdersWithItemDetailsAndStatus('On going');
  //   notifyListeners();
  // }

  // Future<void> countCompleteOrdersWithItemDetails() async {
  //   ordersCompleteWithItemDetails =
  //       await orderService.countOrdersWithItemDetailsAndStatus('Complete');
  //   notifyListeners();
  // }

  // Future<void> countCancelOrdersWithItemDetails() async {
  //   ordersCancelWithItemDetails =
  //       await orderService.countOrdersWithItemDetailsAndStatus('Cancel');
  //   notifyListeners();
  // }

  Future<void> countOrdersWithItemDetails() async {
    ordersWithItemDetails = await orderService.countOrdersWithItemDetails();
    notifyListeners();
  }

  Future<void> countOrdersLast7Days() async {
    ordersLast7Day = await orderService.getOrdersLast7Days();
    notifyListeners();
  }

  void updateIdOrder(String value) {
    idOrder = value;
    notifyListeners();
  }

  void addStops(StopPoint stopPoint) {
    listStopPointStandard.add(stopPoint);
    notifyListeners();
  }

  void removeStops(int index) {
    listStopPointStandard.removeAt(index);
    notifyListeners();
  }

  void removeAllStops() {
    listStopPointStandard.clear();
    notifyListeners();
  }

  void updatePickUp(PickUpPoint pickUpPoint, String value) {
    if (listPickUpPoint.length == 1) {
      listPickUpPoint[0].name = pickUpPoint.name;
      listPickUpPoint[0].phone = pickUpPoint.phone;
      listPickUpPoint[0].address = pickUpPoint.address;
      listPickUpPoint[0].description = pickUpPoint.description;
      listPickUpPoint[0].lat = pickUpPoint.lat;
      listPickUpPoint[0].lng = pickUpPoint.lng;
    } else {
      listPickUpPoint.add(pickUpPoint);
    }
    pickUpAddress = value;
    notifyListeners();
  }

  void updateDropOff(DropOffPoint dropOffPoint, String value) {
    if (listDropOffPoint.length == 1) {
      listDropOffPoint[0].name = dropOffPoint.name;
      listDropOffPoint[0].phone = dropOffPoint.phone;
      listDropOffPoint[0].address = dropOffPoint.address;
      listDropOffPoint[0].description = dropOffPoint.description;
      listDropOffPoint[0].lat = dropOffPoint.lat;
      listDropOffPoint[0].lng = dropOffPoint.lng;
    } else {
      listDropOffPoint.add(dropOffPoint);
    }
    dropOffAddress = value;
    notifyListeners();
  }

  void getPositionMidStop(int value) {
    positionMidStop = value;
    notifyListeners();
  }

  void updateMidStop(StopPoint stopPoint) {
    var index = stopPoint.position;
    listStopPointStandard[index] = stopPoint;
    notifyListeners();
  }

  void updateDateTimeOrder(Orders order, String value) {
    if (listOrders.length == 1) {
      listOrders[0].pickupDatetime = order.pickupDatetime;
    } else {
      listOrders.add(order);
    }
    dateTimeOrder = value;
    notifyListeners();
  }

  void updateValue(int ind) {
    value = ind;
    notifyListeners();
  }

  void updateItemDetailsOrder(Orders order, String value) {
    if (listOrders.length == 1) {
      listOrders[0].itemDetails = order.itemDetails;
    } else {
      listOrders.add(order);
    }
    subTextItemDetails = value;
    notifyListeners();
  }

  void updateDemandOrder(Orders order, String value) {
    if (listOrders.length == 1) {
      listOrders[0].demand = order.demand;
    } else {
      listOrders.add(order);
    }
    subTextDemand = value;
    if (subTextDemand == 'Below 500 kg') {
      lowerDemand = 1;
      upperDemand = 500;
    } else if (subTextDemand == '501 - 1500 kg') {
      lowerDemand = 501;
      upperDemand = 1500;
    } else {
      lowerDemand = 1501;
      upperDemand = 999999;
    }
    notifyListeners();
  }

  void updateNoteOrder(Orders order, String value) {
    if (listOrders.length == 1) {
      listOrders[0].note = order.note;
    } else {
      listOrders.add(order);
    }
    subTextNote = value;
    notifyListeners();
  }

  void updateOptimizeOrder() {
    if (optimize == true) {
      optimize = false;
      listOrders[0].optimize = false;
    } else {
      optimize = true;
      listOrders[0].optimize = true;
    }
    notifyListeners();
  }

  void updateTotalPaymentOrder(double value) {
    listOrders[0].totalPayment = value;
  }

  void updateTruckOrder(Orders order) {
    if (listOrders.length == 1) {
      listOrders[0].idTruck = order.idTruck;
      listOrders[0].idDriver = order.idDriver;
    } else {
      listOrders.add(order);
    }
  }

  Future<void> createOrder(List<StopPoint> listStopPoints) async {
    await orderService
        .createOrder(
      listOrders,
      listPickUpPoint,
      listStopPoints,
      listDropOffPoint,
    )
        .then((value) {
      listOrders.clear();
      listPickUpPoint.clear();
      listStopPointOptimize.clear();
      listStopPointStandard.clear();
      listDropOffPoint.clear();
      pickUpAddress = 'Pick up location';
      dropOffAddress = 'Drop off location';
      dateTimeOrder = 'Pick up time';
      subTextItemDetails = 'Describe the type of your item';
      subTextDemand = 'Estimate the total weight of your items';
      subTextNote = 'Important info the driver should know';
    });
    notifyListeners();
  }

  void removeOrder() {
    listOrders.clear();
    listPickUpPoint.clear();
    listStopPointOptimize.clear();
    listStopPointStandard.clear();
    listDropOffPoint.clear();
    pickUpAddress = 'Pick up location';
    dropOffAddress = 'Drop off location';
    dateTimeOrder = 'Pick up time';
    subTextItemDetails = 'Describe the type of your item';
    subTextDemand = 'Estimate the total weight of your items';
    subTextNote = 'Important info the driver should know';
    removeAllStops();
    notifyListeners();
  }
}
