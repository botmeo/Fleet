import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/utils/validation.dart';
import 'package:fleet_driver/viewmodels/user_view_model.dart';
import 'package:fleet_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Forgot password',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Please enter your email address.',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                controller: emailController,
                validator: (value) => Validation().validateEmail(value),
                labelText: 'Email',
                prefixIcon: Icons.email_outlined,
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    userViewModel.forgotPassword(
                      context,
                      emailController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Reset password',
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
