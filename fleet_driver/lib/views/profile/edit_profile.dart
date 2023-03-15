import 'package:fleet_driver/models/user.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/utils/validation.dart';
import 'package:fleet_driver/viewmodels/user_view_model.dart';
import 'package:fleet_driver/widgets/notification_dialog.dart';
import 'package:fleet_driver/widgets/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController birthdayController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    nameController.text = args['name'];
    birthdayController.text = args['birthday'];
    phoneController.text = args['phone'];

    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit profile',
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
                  action: TextInputAction.next,
                  labelText: 'Name',
                  hintText: 'Name',
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
                        firstDate: DateTime(1900),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );
                      if (dateTime != null) {
                        birthdayController.text = dateTime.toString();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                TextBoxWidget(
                  controller: phoneController,
                  validator: (value) => Validation().validateWhiteSpace(value),
                  action: TextInputAction.done,
                  labelText: 'Phone',
                  hintText: '0378917217',
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
                userViewModel.updateProfile(
                  DriverUser(
                    name: nameController.text.trim(),
                    birthday: birthdayController.text.trim(),
                    phone: phoneController.text.trim(),
                  ),
                );
                showDialog(
                  context: context,
                  builder: (_) => const NotificationDialog(
                    title: Text('Success'),
                    content: Text('The information was successfully updated.'),
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
              'Save',
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
