import 'package:fleet_driver/routes/routes.dart';
import 'package:fleet_driver/utils/constants.dart';
import 'package:fleet_driver/utils/validation.dart';
import 'package:fleet_driver/viewmodels/user_view_model.dart';
import 'package:fleet_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: SvgPicture.asset("assets/images/svg/truck.svg"),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.forgotPassword,
                              );
                            },
                            child: const Text(
                              'Forgot password?',
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        userViewModel.signInWithEmailAndPassword(
                          emailController.text.trim(),
                          passController.text.trim(),
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontFamily: AppFonts.fontsPrimary,
                        fontWeight: AppFonts.boldFonts,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
