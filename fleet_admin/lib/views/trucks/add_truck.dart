import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/models/trucks.dart';
import 'package:fleet_admin/utils/validation.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/views/trucks/components/manufacture_suggest.dart';
import 'package:fleet_admin/widgets/notification_dialog.dart';
import 'package:fleet_admin/widgets/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTruckScreen extends StatelessWidget {
  const AddTruckScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController plateController = TextEditingController();
    TextEditingController modelController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController manufactureController = TextEditingController();
    TextEditingController capacityController = TextEditingController();
    TextEditingController costController = TextEditingController();

    final trucksViewModel = Provider.of<TruckViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add truck',
          style: TextStyle(
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 18, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBoxWidget(
                  controller: plateController,
                  validator: (value) => Validation().validateWhiteSpace(value),
                  action: TextInputAction.next,
                  labelText: 'License Plate',
                  hintText: '17B-180.62',
                ),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextBoxWidget(
                        controller: modelController,
                        labelText: 'Model',
                        hintText: 'New Mighty 110XL',
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextBoxWidget(
                        controller: yearController,
                        action: TextInputAction.done,
                        labelText: 'Year',
                        hintText: '2022',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            CupertinoIcons.calendar,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () async {
                            DateTime dateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (dateTime != null) {
                              yearController.text = dateTime.year.toString();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                ManufactureSuggestComponent(
                  controller: manufactureController,
                  hintText: 'Hyundai',
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: capacityController,
                  validator: (value) =>
                      Validation().validateCapacityTruck(value),
                  action: TextInputAction.next,
                  labelText: 'Capacity',
                  type: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  hintText: '6300',
                  suffixText: const Text(
                    'kg',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: costController,
                  validator: (value) => Validation().validateCostTruck(value),
                  action: TextInputAction.done,
                  labelText: 'Cost/km',
                  type: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  hintText: '74000',
                  suffixText: const Text(
                    'đồng',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState.validate()) {
                trucksViewModel.addTruck(
                  Trucks(
                    licensePlate: plateController.text.trim(),
                    model: modelController.text.trim(),
                    year: yearController.text.trim(),
                    manufacture: manufactureController.text.trim(),
                    capacity: int.parse(capacityController.text.trim()),
                    cost: int.parse(costController.text.trim()),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (_) => const NotificationDialog(
                    title: Text('Success'),
                    content: Text('The truck has been successfully added.'),
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
              'Add truck',
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
    );
  }
}
