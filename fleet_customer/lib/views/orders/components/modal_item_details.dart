import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalItemDetailsOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);

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
          'Item details',
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
            groupValue: orderViewModel.value,
            onChanged: (ind) {
              orderViewModel.updateValue(ind);
              orderViewModel.updateItemDetailsOrder(
                Orders(
                  itemDetails: 'Comestic',
                ),
                'Comestic',
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
                  'Comestic',
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
            groupValue: orderViewModel.value,
            onChanged: (ind) {
              orderViewModel.updateValue(ind);
              orderViewModel.updateItemDetailsOrder(
                Orders(
                  itemDetails: 'Pharma',
                ),
                'Pharma',
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
                  'Pharma',
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
            groupValue: orderViewModel.value,
            onChanged: (ind) {
              orderViewModel.updateValue(ind);
              orderViewModel.updateItemDetailsOrder(
                Orders(
                  itemDetails: 'Food',
                ),
                'Food',
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
                  'Food',
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
            value: 4,
            groupValue: orderViewModel.value,
            onChanged: (ind) {
              orderViewModel.updateValue(ind);
              orderViewModel.updateItemDetailsOrder(
                Orders(
                  itemDetails: 'Equipment',
                ),
                'Equipment',
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
                  'Equipment',
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
            value: 5,
            groupValue: orderViewModel.value,
            onChanged: (ind) {
              orderViewModel.updateValue(ind);
              orderViewModel.updateItemDetailsOrder(
                Orders(
                  itemDetails: 'Other',
                ),
                'Other',
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
                  'Other',
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
