import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleet_customer/models/directions_point.dart';
import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/viewmodels/tsp_view_model.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:fleet_customer/views/orders/components/modal_demand_order.dart';
import 'package:fleet_customer/views/orders/components/modal_item_details.dart';
import 'package:fleet_customer/views/orders/components/modal_note_order.dart';
import 'package:fleet_customer/widgets/notification_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);
    final tspViewModel = Provider.of<TspViewModel>(context);
    TextEditingController noteOrderController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        await mapViewModel.clearMaps();
        await orderViewModel.removeOrder();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          automaticallyImplyLeading: true,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Create order',
            style: TextStyle(
              color: Colors.white,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.boldFonts,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 5, 0, 0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(DateTime.now().year + 5),
                            onConfirm: (date) {
                              orderViewModel.updateDateTimeOrder(
                                Orders(
                                  pickupDatetime: Timestamp.fromDate(date),
                                ),
                                DateFormat.yMMMMd('en_US')
                                    .add_jm()
                                    .format(date),
                              );
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.en,
                            theme: DatePickerTheme(
                              headerColor: AppColors.backgroundColor,
                              backgroundColor: AppColors.backgroundColor,
                              itemStyle: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 14,
                              ),
                              doneStyle: TextStyle(
                                color: AppColors.secondaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                              cancelStyle: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                        leading: const Icon(
                          CupertinoIcons.time_solid,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          orderViewModel.dateTimeOrder,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(DateTime.now().year + 5),
                              onConfirm: (date) {
                                orderViewModel.updateDateTimeOrder(
                                  Orders(
                                    pickupDatetime: Timestamp.fromDate(date),
                                  ),
                                  DateFormat.yMMMMd('en_US')
                                      .add_jm()
                                      .format(date),
                                );
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                              theme: DatePickerTheme(
                                headerColor: AppColors.backgroundColor,
                                backgroundColor: AppColors.backgroundColor,
                                itemStyle: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFonts.fontsPrimary,
                                  fontWeight: AppFonts.regularFonts,
                                  fontSize: 14,
                                ),
                                doneStyle: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontFamily: AppFonts.fontsPrimary,
                                  fontWeight: AppFonts.boldFonts,
                                  fontSize: 14,
                                ),
                                cancelStyle: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontFamily: AppFonts.fontsPrimary,
                                  fontWeight: AppFonts.boldFonts,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.chevron_forward,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.pickUpSearch);
                        },
                        leading: const Icon(
                          CupertinoIcons.cube_box_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          orderViewModel.pickUpAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.chevron_forward,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                      Consumer<OrderViewModel>(
                        builder: (context, provider, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                orderViewModel.listStopPointStandard.length < 5
                                    ? orderViewModel
                                        .listStopPointStandard.length
                                    : 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.midStopSearch,
                                  );
                                  orderViewModel.getPositionMidStop(index);
                                },
                                leading: const Icon(
                                  CupertinoIcons.location_solid,
                                  color: AppColors.secondaryColor,
                                ),
                                horizontalTitleGap: 0,
                                title: Text(
                                  orderViewModel
                                      .listStopPointStandard[index].address
                                      .toString(),
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFonts.fontsPrimary,
                                    fontWeight: AppFonts.regularFonts,
                                    fontSize: 14,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    orderViewModel.removeStops(index);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.clear,
                                    color: AppColors.primaryColor,
                                    size: 14,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.dropOffSearch);
                        },
                        leading: const Icon(
                          CupertinoIcons.archivebox_fill,
                          color: AppColors.secondaryColor,
                        ),
                        horizontalTitleGap: 0,
                        title: Text(
                          orderViewModel.dropOffAddress,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.chevron_forward,
                            color: AppColors.primaryColor,
                            size: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 25, 0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          if (orderViewModel.listStopPointStandard.length < 5) {
                            orderViewModel.addStops(
                              StopPoint(
                                address: 'Mid stop location',
                              ),
                            );
                          }
                        },
                        title: Center(
                          child: Text(
                            'Add stop',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.regularFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          orderViewModel.removeAllStops();
                        },
                        title: Center(
                          child: Text(
                            'Clear stop',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.regularFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 5, 0, 15),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Details',
                          style: const TextStyle(
                            color: AppColors.secondaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Item details',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          orderViewModel.subTextItemDetails,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.subTextColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 12,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalItemDetailsOrder();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.boldFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Demand',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          orderViewModel.subTextDemand,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.subTextColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 12,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalDemandOrder();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.boldFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Note for driver',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          orderViewModel.subTextNote,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.subTextColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 12,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalNoteOrder(
                                  controller: noteOrderController,
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.boldFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Optimize route',
                          style: TextStyle(
                            color: orderViewModel.optimize == true
                                ? AppColors.updateColor
                                : AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          'Optimize your stop point route',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.subTextColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 12,
                          ),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            orderViewModel.updateOptimizeOrder();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                              color: AppColors.backgroundColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.boldFonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: AppColors.backgroundColor,
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  bool isValid = true;
                  bool dialogShow = false;

                  if (!dialogShow && orderViewModel.listPickUpPoint.isEmpty ||
                      orderViewModel.listPickUpPoint[0].name == null) {
                    isValid = false;
                    showDialog(
                      context: context,
                      builder: (_) => const NotificationDialog(
                        title: Text('Error'),
                        content: Text('Pick up point cannot be empty.'),
                      ),
                      barrierDismissible: false,
                    );
                    dialogShow = true;
                  }
                  if (!dialogShow && orderViewModel.listDropOffPoint.isEmpty ||
                      orderViewModel.listDropOffPoint[0].name == null) {
                    isValid = false;
                    showDialog(
                      context: context,
                      builder: (_) => const NotificationDialog(
                        title: Text('Error'),
                        content: Text('Stop point cannot be empty.'),
                      ),
                      barrierDismissible: false,
                    );
                    dialogShow = true;
                  }
                  if (!dialogShow && orderViewModel.listOrders.isEmpty ||
                      orderViewModel.listOrders[0].itemDetails == null) {
                    isValid = false;
                    showDialog(
                      context: context,
                      builder: (_) => const NotificationDialog(
                        title: Text('Error'),
                        content: Text('Item details cannot be empty.'),
                      ),
                      barrierDismissible: false,
                    );
                    dialogShow = true;
                  }
                  if (!dialogShow && orderViewModel.listOrders.isEmpty ||
                      orderViewModel.listOrders[0].demand == null) {
                    isValid = false;
                    showDialog(
                      context: context,
                      builder: (_) => const NotificationDialog(
                        title: Text('Error'),
                        content: Text('Demand cannot be empty.'),
                      ),
                      barrierDismissible: false,
                    );
                    dialogShow = true;
                  }
                  if (!dialogShow && orderViewModel.listOrders.isEmpty ||
                      orderViewModel.listOrders[0].pickupDatetime == null) {
                    isValid = false;
                    showDialog(
                      context: context,
                      builder: (_) => const NotificationDialog(
                        title: Text('Error'),
                        content: Text('Pick up datetime cannot be empty.'),
                      ),
                      barrierDismissible: false,
                    );
                    dialogShow = true;
                  }
                  if (isValid) {
                    mapViewModel.addPickUpMarker(
                      orderViewModel.listPickUpPoint[0].address,
                      orderViewModel.listPickUpPoint[0].lat,
                      orderViewModel.listPickUpPoint[0].lng,
                    );
                    mapViewModel.addDropOffMarker(
                      orderViewModel.listDropOffPoint[0].address,
                      orderViewModel.listDropOffPoint[0].lat,
                      orderViewModel.listDropOffPoint[0].lng,
                    );
                    if (orderViewModel.listStopPointStandard.isNotEmpty) {
                      mapViewModel.addStopMarker(
                        orderViewModel.listStopPointStandard.length,
                        orderViewModel.listStopPointStandard,
                      );
                      if (orderViewModel.optimize == true) {
                        await tspViewModel.optimizeRoute(
                            orderViewModel.listStopPointStandard);
                        orderViewModel.listStopPointOptimize =
                            tspViewModel.stopPoints;
                        orderViewModel.listOrders[0].optimize = true;
                        mapViewModel.addWayPoints(
                          orderViewModel.listStopPointOptimize.length,
                          orderViewModel.listStopPointOptimize,
                        );
                      } else {
                        orderViewModel.listOrders[0].optimize = false;
                        mapViewModel.addWayPoints(
                          orderViewModel.listStopPointStandard.length,
                          orderViewModel.listStopPointStandard,
                        );
                      }
                    }
                    await mapViewModel.getDirections(
                      DirectionPoint(
                        startLat: orderViewModel.listPickUpPoint[0].lat,
                        startLng: orderViewModel.listPickUpPoint[0].lng,
                        endLat: orderViewModel.listDropOffPoint[0].lat,
                        endLng: orderViewModel.listDropOffPoint[0].lng,
                      ),
                    );
                    mapViewModel.setCustomMarker();
                    orderViewModel.listOrders[0].totalDistance =
                        double.parse(mapViewModel.totalDistance);
                    orderViewModel.updateTotalPaymentOrder(
                        double.parse(mapViewModel.totalDistance) * 25000);
                    userViewModel.getBalance();
                    Navigator.pushNamed(context, Routes.selectVehicle);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.boldFonts,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
