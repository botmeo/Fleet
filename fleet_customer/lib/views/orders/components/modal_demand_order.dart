import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/viewmodels/truck_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalDemandOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final truckViewModel = Provider.of<TruckViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.clear,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
        title: const Text(
          'Demand',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            fontSize: 14,
          ),
        ),
      ),
      body: ListView(
        children: [
          RadioListTile(
            value: 1,
            groupValue: truckViewModel.value,
            onChanged: (ind) {
              truckViewModel.updateValue(ind);
              orderViewModel.updateDemandOrder(
                Orders(
                  demand: 'Below 500 kg',
                ),
                'Below 500 kg',
              );
              Navigator.pop(context);
            },
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: AppColors.secondaryColor,
            title: Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Below 500 kg',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile(
            value: 2,
            groupValue: truckViewModel.value,
            onChanged: (ind) {
              truckViewModel.updateValue(ind);
              orderViewModel.updateDemandOrder(
                Orders(
                  demand: '501 - 1500 kg',
                ),
                '501 - 1500 kg',
              );
              Navigator.pop(context);
            },
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: AppColors.secondaryColor,
            title: Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Text(
                  '501 - 1000 kg',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          RadioListTile(
            value: 3,
            groupValue: truckViewModel.value,
            onChanged: (ind) {
              truckViewModel.updateValue(ind);
              orderViewModel.updateDemandOrder(
                Orders(
                  demand: 'Above 1500 kg',
                ),
                'Above 1500 kg',
              );
              Navigator.pop(context);
            },
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: AppColors.secondaryColor,
            title: Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Text(
                  'Above 1500 kg',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
