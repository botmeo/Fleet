import 'package:fleet_customer/models/orders.dart';
import 'package:fleet_customer/utils/constants.dart';
import 'package:fleet_customer/utils/validation.dart';
import 'package:fleet_customer/viewmodels/google_map_view_model.dart';
import 'package:fleet_customer/viewmodels/order_view_model.dart';
import 'package:fleet_customer/widgets/divider.dart';
import 'package:fleet_customer/widgets/text_box.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DropOffLocationScreen extends StatefulWidget {
  DropOffLocationScreen({Key key}) : super(key: key);

  @override
  State<DropOffLocationScreen> createState() => _DropOffLocationScreenState();
}

class _DropOffLocationScreenState extends State<DropOffLocationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameReceiverController = TextEditingController();
  final TextEditingController phoneReceiverController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mapViewModel = Provider.of<GoogleMapViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);
    final lat = mapViewModel.placeDetails.result.geometry.location.lat;
    final lng = mapViewModel.placeDetails.result.geometry.location.lng;
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Drop off details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.fontsPrimary,
            fontWeight: AppFonts.boldFonts,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Drop off at',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontFamily: AppFonts.fontsPrimary,
                        fontWeight: AppFonts.boldFonts,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const DividerComponent(),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                height: 160,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initialCameraPosition,
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId('Id'),
                      position: LatLng(lat, lng),
                    ),
                  },
                ),
              ),
              ListTile(
                title: Text(
                  mapViewModel.placeDetails.result.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.boldFonts,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  mapViewModel.placeDetails.result.formattedAddress ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.subTextColor,
                    fontFamily: AppFonts.fontsPrimary,
                    fontWeight: AppFonts.regularFonts,
                    fontSize: 12,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontFamily: AppFonts.fontsPrimary,
                      fontWeight: AppFonts.boldFonts,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const DividerComponent(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Receiver information',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontFamily: AppFonts.fontsPrimary,
                        fontWeight: AppFonts.boldFonts,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  children: [
                    TextBoxWidget(
                      controller: nameReceiverController,
                      validator: (value) =>
                          Validation().validateWhiteSpace(value),
                      action: TextInputAction.next,
                      labelText: 'Name',
                      hintText: 'Hoang Hai',
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    TextBoxWidget(
                      controller: phoneReceiverController,
                      validator: (value) =>
                          Validation().validateWhiteSpace(value),
                      type: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      action: TextInputAction.done,
                      labelText: 'Phone',
                      hintText: '0378917214',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState.validate()) {
                await orderViewModel.updateDropOff(
                  DropOffPoint(
                    name: nameReceiverController.text,
                    phone: phoneReceiverController.text,
                    address: mapViewModel.placeDetails.result.name,
                    description:
                        mapViewModel.placeDetails.result.formattedAddress,
                    lat: lat,
                    lng: lng,
                  ),
                  mapViewModel.placeDetails.result.name,
                );
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Confirm',
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
