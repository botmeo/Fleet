import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/views/favorite/components/modal_favorite_driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteDriverScreen extends StatelessWidget {
  const FavoriteDriverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneDriver = new TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favorite driver',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ModalFavoriteDriver(
                      controller: phoneDriver,
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Add favorite driver',
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
