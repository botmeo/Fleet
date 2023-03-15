import 'package:fleet_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class TextBoxWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixText;
  final Widget suffixIcon;
  final Function validator;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;

  const TextBoxWidget({
    Key key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixText,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.type,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
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
          validator: validator,
          textInputAction: action,
          keyboardType: type,
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
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffix: suffixText,
            suffixIcon: suffixIcon,
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
    );
  }
}
