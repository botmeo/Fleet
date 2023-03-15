import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:fleet_customer/widgets/notification_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Confirm order',
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
                        'Delivery details',
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
                        'Preview order',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.regularFonts,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        '${orderViewModel.listStopPointStandard.length + 1} stop points',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.subTextColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.regularFonts,
                          fontSize: 12,
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.currentOrderDetails,
                        );
                      },
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
                padding: const EdgeInsets.fromLTRB(13, 5, 0, 5),
                child: Column(
                  children: [
                    ListTile(
                      title: RichText(
                        text: TextSpan(
                          text: 'Total payment ',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${NumberFormat.simpleCurrency(name: 'VND', decimalDigits: 0).format(orderViewModel.listOrders[0].totalPayment)}',
                              style: const TextStyle(
                                color: AppColors.updateColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.regularFonts,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            //   decoration: BoxDecoration(
            //     color: AppColors.backgroundColor,
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(12),
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.1),
            //         spreadRadius: 5,
            //         blurRadius: 7,
            //         offset: const Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(13, 5, 0, 15),
            //     child: Column(
            //       children: [
            //         ListTile(
            //           title: Text(
            //             'Special requests',
            //             style: const TextStyle(
            //               color: AppColors.secondaryColor,
            //               fontFamily: AppFonts.fontsPrimary,
            //               fontWeight: AppFonts.boldFonts,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ),
            //         ListTile(
            //           title: Text(
            //             'Carriers',
            //             style: const TextStyle(
            //               color: AppColors.primaryColor,
            //               fontFamily: AppFonts.fontsPrimary,
            //               fontWeight: AppFonts.regularFonts,
            //               fontSize: 14,
            //             ),
            //           ),
            //           subtitle: Text(
            //             '200,000 đ',
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //             style: const TextStyle(
            //               color: AppColors.subTextColor,
            //               fontFamily: AppFonts.fontsPrimary,
            //               fontWeight: AppFonts.regularFonts,
            //               fontSize: 12,
            //             ),
            //           ),
            //           trailing: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //               primary: AppColors.secondaryColor,
            //               shadowColor: Colors.transparent,
            //             ),
            //             child: const Text(
            //               'Add',
            //               style: TextStyle(
            //                 color: AppColors.backgroundColor,
            //                 fontFamily: AppFonts.fontsPrimary,
            //                 fontWeight: AppFonts.boldFonts,
            //                 fontSize: 14,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
              onPressed: () {
                if (userViewModel.currentBalance >
                    orderViewModel.listOrders[0].totalPayment) {
                  if (orderViewModel.listOrders[0].optimize == true) {
                    orderViewModel
                        .createOrder(orderViewModel.listStopPointOptimize);
                  } else {
                    orderViewModel
                        .createOrder(orderViewModel.listStopPointStandard);
                  }
                  userViewModel.deductFromAccount(userViewModel.currentBalance -
                      orderViewModel.listOrders[0].totalPayment);
                  mapViewModel.clearMaps();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => const NotificationDialog(
                      title: Text('Error'),
                      content: Text('Insufficient account balance.'),
                    ),
                    barrierDismissible: false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Confirm',
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
    );
  }
}
