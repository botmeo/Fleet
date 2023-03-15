import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/viewmodels/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountCompleteOrders extends StatelessWidget {
  const CountCompleteOrders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return FutureBuilder(
      future: orderViewModel.countCompleteOrders(),
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Complete',
                          style: TextStyle(
                            color: AppColors.updateColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          orderViewModel.completeOrdersCount.toString(),
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
