import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({Key key}) : super(key: key);

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
          'Top up',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            RadioListTile(
              value: 1,
              groupValue: userViewModel.value,
              onChanged: (ind) {
                userViewModel.changBalanceUser(ind, 100000);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.secondaryColor,
              title: Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '100,000 đ',
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
            RadioListTile(
              value: 2,
              groupValue: userViewModel.value,
              onChanged: (ind) {
                userViewModel.changBalanceUser(ind, 200000);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.secondaryColor,
              title: Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '200,000 đ',
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
            RadioListTile(
              value: 3,
              groupValue: userViewModel.value,
              onChanged: (ind) {
                userViewModel.changBalanceUser(ind, 500000);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.secondaryColor,
              title: Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '500,000 đ',
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
            RadioListTile(
              value: 4,
              groupValue: userViewModel.value,
              onChanged: (ind) {
                userViewModel.changBalanceUser(ind, 1000000);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.secondaryColor,
              title: Row(
                children: [
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    '1,000,000 đ',
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (userViewModel.newBalance != 0) {
                userViewModel.topUpAccount();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              // 'Select payment method',
              'Pay',
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
