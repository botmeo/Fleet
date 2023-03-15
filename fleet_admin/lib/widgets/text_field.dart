import 'package:fleet_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;
  final TextInputAction action;

  const TextFieldWidget({
    Key key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.controller,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: action,
      obscureText: obscureText,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontFamily: AppFonts.fontsPrimary,
        fontWeight: AppFonts.boldFonts,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontFamily: AppFonts.fontsPrimary,
          fontWeight: AppFonts.boldFonts,
        ),
        errorStyle: const TextStyle(
          color: AppColors.errorColor,
          fontFamily: AppFonts.fontsPrimary,
          fontWeight: AppFonts.boldFonts,
        ),
        focusColor: AppColors.primaryColor,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        prefixIcon: Icon(
          prefixIcon,
          size: 18,
          color: AppColors.primaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Icon(
            suffixIcon,
            size: 18,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
