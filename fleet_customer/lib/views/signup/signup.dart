import 'package:fleet_customer/models/customers.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/utils/validation.dart';
import 'package:fleet_customer/viewmodels/user_view_model.dart';
import 'package:fleet_customer/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    // final baseViewModel = Provider.of<BaseViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Create account',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: AppFonts.fontsPrimary,
                        fontWeight: AppFonts.boldFonts,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Already a member? ",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: AppFonts.fontsPrimary,
                        fontWeight: AppFonts.boldFonts,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontFamily: AppFonts.fontsPrimary,
                          fontWeight: AppFonts.boldFonts,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      controller: nameController,
                      validator: (value) =>
                          Validation().validateWhiteSpace(value),
                      labelText: 'Name',
                      prefixIcon: Icons.person_outline,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      controller: phoneController,
                      validator: (value) =>
                          Validation().validateWhiteSpace(value),
                      type: TextInputType.number,
                      labelText: 'Phone',
                      prefixIcon: Icons.phone_outlined,
                      obscureText: false,
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
                    TextFieldWidget(
                      controller: passController,
                      validator: (value) =>
                          Validation().validatePassword(value),
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         signupProvider.isSelected = !signupProvider.isSelected;
                //       },
                //       child: Container(
                //         width: 15,
                //         height: 15,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(4),
                //           border: Border.all(
                //             color: AppColors.primaryColor,
                //             width: 1.5,
                //           ),
                //         ),
                //         child: signupProvider.isSelected
                //             ? const Icon(
                //                 Icons.check,
                //                 size: 12,
                //                 color: Colors.green,
                //               )
                //             : null,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 6,
                //     ),
                //     const Text(
                //       'I agree to the terms and conditions.',
                //       style: TextStyle(
                //         color: AppColors.primaryColor,
                //         fontFamily: AppFonts.fontsPrimary,
                //         fontWeight: AppFonts.boldFonts,
                //         fontSize: 14,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        userViewModel.signUpWithEmailAndPassword(
                          emailController.text.trim(),
                          passController.text.trim(),
                          Customers(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email: emailController.text.trim(),
                          ),
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.backgroundColor,
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Register',
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
      ),
    );
  }
}
