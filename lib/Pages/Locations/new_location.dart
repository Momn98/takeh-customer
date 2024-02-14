import 'package:takeh_customer/Pages/Locations/map-search/address_search.dart';
import 'package:takeh_customer/Pages/Locations/map-search/place_service.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class NewLocationSelect extends StatefulWidget {
  final String text;
  const NewLocationSelect({Key? key, required this.text}) : super(key: key);

  @override
  State<NewLocationSelect> createState() => _NewLocationSelectState();
}

class _NewLocationSelectState extends State<NewLocationSelect> {
  String locationName = '${S.current.checking} ...';

  @override
  void initState() {
    locationProvider.getLocation(context);
    super.initState();
  }

  @override
  void dispose() {
    locationProvider.controller = Completer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (_, v, __) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () => NavMove.goBack(context),
            ),
            backgroundColor: AppColor.orange,
            title: InkWell(
              child: Container(
                margin: EdgeInsetsDirectional.only(end: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 10),
                    Text(
                      '${S.current.searchForYourAddress} ...',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                final sessionToken = const Uuid().v4();
                final Suggestion? result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );

                // This will change the text displayed in the TextField
                if (result != null && result.placeId != '') {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  v.placemarks = await placemarkFromCoordinates(
                    placeDetails.lat,
                    placeDetails.lng,
                    localeIdentifier:
                        '${tabBarProvider.locale.languageCode}_JO',
                  );
                  setState(() {
                    locationProvider.animateTo(
                        placeDetails.lat, placeDetails.lng);
                  });
                }
              },
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                if (v.haveLocation)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: MapPicker(
                      iconWidget: Image(
                        image: IconSvg.location,
                        height: 90,
                      ),
                      //add map picker controller
                      mapPickerController: v.mapPickerController,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        // hide location button
                        myLocationButtonEnabled: true,
                        // mapType: MapType.normal,
                        //  camera position
                        initialCameraPosition: v.position,
                        // ignore: unnecessary_lambdas
                        onMapCreated: (GoogleMapController controller) {
                          // _controller = controller;
                          try {
                            v.controller.complete(controller);
                          } catch (e) {}

                          v.animateTo(v.position.target.latitude,
                              v.position.target.longitude);
                          setState(() {});
                        },
                        onCameraMoveStarted: () {
                          // notify map is moving
                          v.mapPickerController.mapMoving!();
                          setState(
                              () => locationName = '${S.current.checking} ...');
                        },
                        onCameraMove: (cameraPosition) {
                          v.position = cameraPosition;
                        },
                        onCameraIdle: () async {
                          // notify map stopped moving
                          v.mapPickerController.mapFinishedMoving!();
                          // get address name from camera position
                          v.placemarks = await placemarkFromCoordinates(
                            v.position.target.latitude,
                            v.position.target.longitude,
                            localeIdentifier:
                                '${tabBarProvider.locale.languageCode}_JO',
                          );

                          // update the ui with the address
                          setState(() {
                            locationName =
                                '${v.placemarks.first.thoroughfare} ${v.placemarks.first.subLocality}';
                          });
                        },
                      ),
                    ),
                  ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          S.current.location,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        setHeightSpace(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.map_pin,
                              color: AppColor.secondary,
                            ),
                            setWithSpace(5),
                            Expanded(
                              child: Text(locationName),
                            ),
                          ],
                        ),
                        setHeightSpace(5),
                        Row(
                          children: [
                            Expanded(
                              child: globalButton(
                                widget.text,
                                () => Navigator.pop(context, {
                                  'location_name': locationName,
                                  'placemark': v.placemarks.first,
                                  'location_selected': true,
                                  'latitude': v.position.target.latitude,
                                  'longitude': v.position.target.longitude,
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        );
      },
    );
  }
}
