import 'package:fleet_admin/data/manufacture.dart';
import 'package:fleet_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ManufactureSuggestComponent extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const ManufactureSuggestComponent({
    Key key,
    this.hintText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
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
      suggestionsCallback: (pattern) {
        return manufacture.where(
          (item) => item.toLowerCase().contains(
                pattern.toLowerCase(),
              ),
        );
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.regularFonts,
              fontSize: 14,
            ),
          ), 
        );
      },
      noItemsFoundBuilder: (context) {
        return const ListTile(
          title: Text(
            'No item found',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: AppFonts.fontsPrimary,
              fontWeight: AppFonts.regularFonts,
              fontSize: 14,
            ),
          ),
        );
      },
      onSuggestionSelected: (String suggestion) {
        controller.text = suggestion;
      },
    );
  }
}
