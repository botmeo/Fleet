import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/models/trucks.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/viewmodels/truck_view_model.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListTrucksScreen extends StatelessWidget {
  const ListTrucksScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truckViewModel = Provider.of<TruckViewModel>(context);
    final driverViewModel = Provider.of<DriverViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Trucks',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: TextFormField(
                onChanged: (value) {
                  truckViewModel.updateValueQuery(value);
                },
                textInputAction: TextInputAction.search,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.regularFonts,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusColor: AppColors.primaryColor,
                  hintText: 'Search',
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 14,
                  ),
                  errorStyle: TextStyle(
                    color: AppColors.errorColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.boldFonts,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Trucks>>(
                stream: truckViewModel.query.isNotEmpty
                    ? truckViewModel.searchTruck(truckViewModel.query)
                    : truckViewModel.listTrucks,
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
                                  'There are no active trucks',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFonts.fontsPrimary,
                                    fontWeight: AppFonts.regularFonts,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'You can add trucks for business',
                                  style: TextStyle(
                                    color: AppColors.subTextColor,
                                    fontFamily: AppFonts.fontsPrimary,
                                    fontWeight: AppFonts.regularFonts,
                                    fontSize: 12,
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
                      return Slidable(
                        key: Key(truck.id),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                truckViewModel.updateIdTruck(truck.id);
                                Navigator.pushNamed(
                                  context,
                                  Routes.locationTruck,
                                );
                              },
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: AppColors.backgroundColor,
                              label: 'Location',
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.editTruck,
                                  arguments: {
                                    'id': truck.id,
                                    'plate': truck.licensePlate,
                                    'model': truck.model,
                                    'year': truck.year,
                                    'manufacture': truck.manufacture,
                                    'capacity': truck.capacity,
                                    'cost': truck.cost,
                                  },
                                );
                              },
                              backgroundColor: AppColors.updateColor,
                              foregroundColor: AppColors.backgroundColor,
                              label: 'Update',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(
                            onDismissed: () {
                              truckViewModel.deleteTruck(data[index].id);
                            },
                          ),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                truckViewModel.deleteTruck(data[index].id);
                              },
                              backgroundColor: AppColors.errorColor,
                              foregroundColor: AppColors.backgroundColor,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 2, 2, 0),
                          padding: const EdgeInsets.all(6),
                          child: ListTile(
                            title: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.bus,
                                  color: AppColors.primaryColor,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      truck.licensePlate ?? '',
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFonts.fontsPrimary,
                                        fontWeight: AppFonts.boldFonts,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      truck.licensePlate ?? '',
                                      style: const TextStyle(
                                        color: AppColors.subTextColor,
                                        fontFamily: AppFonts.fontsPrimary,
                                        fontWeight: AppFonts.regularFonts,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              truckViewModel.updateIdTruck(truck.id);
                              driverViewModel.updateIdDriver(truck.used);
                              Navigator.pushNamed(context, Routes.infoTruck);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTruck);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(
          CupertinoIcons.add,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }
}
