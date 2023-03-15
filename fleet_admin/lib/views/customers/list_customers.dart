import 'package:fleet_admin/models/customers.dart';
import 'package:fleet_admin/routes/routes.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/customer_view_model.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListCustomersScreen extends StatelessWidget {
  const ListCustomersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customersViewModel = Provider.of<CustomerViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Customers',
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
                  customersViewModel.updateValueQuery(value);
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
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Customers>>(
                stream: customersViewModel.query.isNotEmpty
                    ? customersViewModel
                        .searchCustomer(customersViewModel.query)
                    : customersViewModel.listCustomers,
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
                                  CupertinoIcons.person_3_fill,
                                  color: AppColors.primaryColor,
                                  size: 55,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'There are no customers',
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
                                  'You can add customers for business',
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
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final customer = data[index];
                      return Column(
                        children: [
                          Slidable(
                            key: Key(customer.id),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    FlutterPhoneDirectCaller.callNumber(
                                      customer.phone,
                                    );
                                  },
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: AppColors.backgroundColor,
                                  label: 'Call',
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                              padding: const EdgeInsets.all(6),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.person_fill,
                                      color: AppColors.primaryColor,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          customer.name ?? '',
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
                                          customer.phone ?? '',
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
                                  customersViewModel
                                      .updateIdCustomer(customer.id);
                                  Navigator.pushNamed(
                                    context,
                                    Routes.infoCustomer,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
