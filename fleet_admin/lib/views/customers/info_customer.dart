import 'package:fleet_admin/models/customers.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/viewmodels/customer_view_model.dart';
import 'package:fleet_admin/views/customers/components/line_chart_orders_days.dart';
import 'package:fleet_admin/views/customers/components/row_info_customer.dart';
import 'package:fleet_admin/widgets/divider.dart';
import 'package:fleet_admin/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoCustomerScreen extends StatelessWidget {
  const InfoCustomerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerViewModel = Provider.of<CustomerViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Information customer',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Customers>>(
          stream: customerViewModel.customerWithId,
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
                            'No infomation customer',
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
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
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
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Information',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
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
                      const DividerComponent(),
                      RowInfoCustomer(
                        title: data[0].name,
                        subTitle: 'Name',
                      ),
                      const DividerComponent(),
                      RowInfoCustomer(
                        title: data[0].phone,
                        subTitle: 'Phone',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const LineChartOrdersDays(),
              ],
            );
          },
        ),
      ),
    );
  }
}
