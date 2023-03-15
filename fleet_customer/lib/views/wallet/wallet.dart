import 'package:fleet_customer/models/customers.dart';
import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Wallet',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 20, 17, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: AppFonts.fontsPrimary,
                                fontWeight: AppFonts.boldFonts,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            StreamBuilder<List<Customers>>(
                              stream: userViewModel.infoUser,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    color: AppColors.backgroundColor,
                                  );
                                }
                                final data = snapshot.data;
                                if (data.isEmpty) {
                                  return Text(
                                    'đ0',
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontFamily: AppFonts.fontsPrimary,
                                      fontWeight: AppFonts.boldFonts,
                                      fontSize: 26,
                                    ),
                                  );
                                }
                                var currentBalance =
                                    NumberFormat.simpleCurrency(
                                            name: 'VND', decimalDigits: 0)
                                        .format(data[0].balance);
                                userViewModel
                                    .updateCurrentBalance(data[0].balance);
                                return Text(
                                  currentBalance,
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFonts.fontsPrimary,
                                    fontWeight: AppFonts.boldFonts,
                                    fontSize: 26,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.topUp);
                        },
                        child: const Text(
                          'Top up',
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.boldFonts,
                            fontSize: 14,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Bank account',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.boldFonts,
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                color: AppColors.primaryColor,
                size: 14,
              ),
            ),
            ListTile(
              title: Text(
                'Payment methods',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.boldFonts,
                  fontSize: 14,
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_forward,
                color: AppColors.primaryColor,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
