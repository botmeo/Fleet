// import 'package:fleet_customer/services/network_utility.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalSearchStops extends StatelessWidget {
  const ModalSearchStops({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.4,
        maxChildSize: 1,
        snapSizes: const [0.4, 1],
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 43,
                          height: 3.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 7, 15, 0),
                        child: TextFormField(
                          onChanged: (value) {
                            // placeAutoComplete(value);
                          },
                          cursorColor: AppColors.primaryColor,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: AppFonts.fontsPrimary,
                            fontWeight: AppFonts.regularFonts,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(16),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusColor: AppColors.primaryColor,
                            hintText: 'Add or find stops',
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.regularFonts,
                              fontSize: 14,
                            ),
                            errorStyle: TextStyle(
                              color: AppColors.errorColor,
                              fontFamily: AppFonts.fontsPrimary,
                              fontWeight: AppFonts.boldFonts,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.errorColor,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.errorColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // ListView.builder(
                //   itemCount: placePredictions.length,
                //   itemBuilder: (context, index) => Text(
                //     placePredictions[index].description,
                //   ),
                // ),
              ],
            ),
          );
        },
      );
}
