import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalNoteOrder extends StatelessWidget {
  final TextEditingController controller;

  const ModalNoteOrder({
    Key key,
    this.controller,
  }) : super(key: key);

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
          'Note for driver',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
            fontSize: 14,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Note',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.boldFonts,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: controller,
                maxLines: 10,
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.fontsPrimary,
                  fontWeight: AppFonts.regularFonts,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusColor: AppColors.primaryColor,
                  hintText: 'Building name ... ',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 14,
                  ),
                  errorStyle: const TextStyle(
                    color: AppColors.errorColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.boldFonts,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.backgroundColor,
        child: Container(
          margin: const EdgeInsets.all(15),
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              orderViewModel.updateNoteOrder(
                Orders(
                  note: controller.text.trim(),
                ),
                controller.text.trim(),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Confirm',
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
