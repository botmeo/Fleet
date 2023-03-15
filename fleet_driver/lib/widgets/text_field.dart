import 'package:fleet_driver/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;

  const TextFieldWidget({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontFamily: AppFonts.fontsPrimary,
        fontWeight: AppFonts.boldFonts,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        focusColor: AppColors.primaryColor,
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontFamily: AppFonts.fontsPrimary,
          fontWeight: AppFonts.boldFonts,
        ),
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
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          size: 18,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
