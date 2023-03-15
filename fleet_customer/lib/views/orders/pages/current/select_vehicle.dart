import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/models/trucks.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/viewmodels/truck_view_model.dart';
import 'package:fleet_customer/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectVehicleScreen extends StatelessWidget {
  const SelectVehicleScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final truckViewModel = Provider.of<TruckViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Select vehicle',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Trucks>>(
          stream: truckViewModel.listTruckFree(
            orderViewModel.lowerDemand,
            orderViewModel.upperDemand,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: ColorLoader(),
              );
            }
            final data = snapshot.data;
            if (data.isEmpty) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.bus,
                            color: AppColors.primaryColor,
                            size: 55,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'No applicable trucks',
                            style: TextStyle(
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
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final truck = data[index];
                return RadioListTile(
                  value: index,
                  groupValue: truckViewModel.value,
                  onChanged: (ind) {
                    truckViewModel.updateValue(ind);
                    orderViewModel.updateTruckOrder(
                      Orders(
                        idTruck: truck.id,
                        idDriver: truck.used,
                      ),
                    );
                  },
                  activeColor: AppColors.secondaryColor,
                  title: Text(
                    truck.licensePlate,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    truck.capacity.toString() + ' kg',
                    style: const TextStyle(
                      color: AppColors.subTextColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            );
          },
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
                if (orderViewModel.listOrders[0].idTruck != null) {
                  Navigator.pushNamed(context, Routes.confirmOrder);
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
    );
  }
}
