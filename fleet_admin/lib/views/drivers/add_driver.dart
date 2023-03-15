import 'package:fleet_admin/utils/constants.dart';
import 'package:fleet_admin/models/drivers.dart';
import 'package:fleet_admin/utils/validation.dart';
import 'package:fleet_admin/viewmodels/driver_view_model.dart';
import 'package:fleet_admin/widgets/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDriverScreen extends StatelessWidget {
  const AddDriverScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController birthdayController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    final driversViewModel = Provider.of<DriverViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add driver',
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
                  controller: nameController,
                  validator: (value) => Validation().validateWhiteSpace(value),
                  labelText: 'Name',
                  hintText: 'Hoang Hai',
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: birthdayController,
                  validator: (value) => Validation().validateWhiteSpace(value),
                  labelText: 'Date of birth',
                  hintText: '12/30/2022',
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
                        birthdayController.text =
                            DateFormat.yMd().format(dateTime);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: emailController,
                  validator: (value) => Validation().validateEmail(value),
                  labelText: 'Email',
                  hintText: 'hoanghai@gmail.com',
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: phoneController,
                  validator: (value) => Validation().validateWhiteSpace(value),
                  labelText: 'Phone',
                  type: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  hintText: '0378912345',
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
                driversViewModel.addDriverAndSignUp(
                  emailController.text.trim(),
                  Drivers(
                    name: nameController.text.trim(),
                    birthday: birthdayController.text.trim(),
                    phone: phoneController.text.trim(),
                    email: emailController.text.trim(),
                  ),
                  context,
                );
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
    );
  }
}
