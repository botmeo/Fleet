import 'package:fleet_customer/routes/routes.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/views/orders/components/location_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropOffSearchScreen extends StatelessWidget {
  const DropOffSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Drop off',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: TextFormField(
                onChanged: (value) {
                  mapViewModel.searchPlaceAutoComplete(value);
                },
                textInputAction: TextInputAction.search,
                style: TextStyle(
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
                  hintText: 'Number, street, ward, district, city',
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
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
                      color: Colors.transparent,
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
          Expanded(
            child: mapViewModel.placeAutoComplete != null
                ? ListView.builder(
                    itemCount:
                        mapViewModel.placeAutoComplete.predictions.length,
                    itemBuilder: (context, index) {
                      return LocationListTile(
                        press: () async {
                          await mapViewModel.getPlaceDetails(
                            mapViewModel
                                .placeAutoComplete.predictions[index].placeId,
                          );

                          Navigator.pushNamed(
                            context,
                            Routes.dropOffLocation,
                          );
                        },
                        location: mapViewModel
                            .placeAutoComplete.predictions[index].description,
                      );
                    },
                  )
                : Center(
                    child: Text(''),
                  ),
          ),
        ],
      ),
    );
  }
}
