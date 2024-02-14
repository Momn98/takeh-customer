// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:takeh_customer/Global/ChooseYesNo.dart';
// import 'package:takeh_customer/Global/HomeAppBar.dart';
// import 'package:takeh_customer/Global/input.dart';
// import 'package:takeh_customer/Global/loadingDialog.dart';
// import 'package:takeh_customer/Pages/Locations/new_location.dart';
// import 'package:takeh_customer/Provider/AddressProvider.dart';
// import 'package:takeh_customer/Provider/LocationProvider.dart';
// import 'package:takeh_customer/Shared/Constant.dart';
// import 'package:takeh_customer/Shared/Globals.dart';
// import 'package:takeh_customer/Shared/NavMove.dart';
// import 'package:takeh_customer/Shared/i18n.dart';

// import 'package:takeh_customer/main.dart';

// class AddAddress extends StatefulWidget {
//   const AddAddress({Key? key}) : super(key: key);

//   @override
//   _AddAddressState createState() => _AddAddressState();
// }

// class _AddAddressState extends State<AddAddress> {
//   // String addressPlace = S.current.selectAddress;
//   TextEditingController addressText = TextEditingController();
//   // TextEditingController name = TextEditingController();
//   TextEditingController building = TextEditingController();
//   TextEditingController apartment = TextEditingController();
//   // TextEditingController street = TextEditingController();
//   // TextEditingController note = TextEditingController();
//   GlobalKey<FormState> formKey = new GlobalKey<FormState>();

//   FocusNode addressNode = FocusNode();
//   FocusNode buildingNode = FocusNode();
//   FocusNode apartmentNode = FocusNode();

//   @override
//   void initState() {
//     locationProvider.getLocation();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GlobalSafeArea(
//       appBar: HomeAppBar(text: S.current.addNewAddress),
//       body: Scaffold(
//         body: Consumer2<LocationProvider, AddressProvider>(
//           builder: (_, v, v2, __) {
//             return SingleChildScrollView(
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     globalText(
//                       S.current.youCanChooseTheLocationUsingTheMap,
//                       style: TextStyle(fontSize: 16),
//                     ),

//                     setHeightSpace(20),
//                     InkWell(
//                       onTap: () => selectLocation(),
//                       child: Container(
//                         height: MediaQuery.of(context).size.width * 0.6,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             width: 0.8,
//                             color: AppColor.secondary,
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: GoogleMap(
//                                 markers: Set<Marker>.of(v.markers.values),
//                                 initialCameraPosition: CameraPosition(
//                                   target: v.theLocation,
//                                   zoom: 14,
//                                 ),
//                                 onMapCreated:
//                                     (GoogleMapController controller) async {
//                                   try {
//                                     v.controller.complete(controller);
//                                   } catch (e) {}
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               left: 0,
//                               right: 0,
//                               top: 0,
//                               bottom: 0,
//                               child: InkWell(
//                                 onTap: () => selectLocation(),
//                                 child: Container(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     //
//                     setHeightSpace(20),
//                     //

//                     Container(
//                       child: Column(
//                         children: [
//                           authTextFiled(
//                             addressText,
//                             S.current.location,
//                             // focusNode: addressNode,
//                             // nextFocusNode: buildingNode,
//                             validator: (p0) {
//                               if (p0!.length == 0)
//                                 return S.current.thisFieldIsRequired;

//                               return null;
//                             },
//                           ),
//                           setHeightSpace(20),
//                           authTextFiled(
//                             building,
//                             S.current.building,
//                             // focusNode: buildingNode,
//                             // nextFocusNode: apartmentNode,
//                             // onlyNumber: true,
//                             validator: (p0) {
//                               if (p0!.length == 0)
//                                 return S.current.thisFieldIsRequired;

//                               return null;
//                             },
//                           ),
//                           setHeightSpace(20),
//                           authTextFiled(
//                             apartment,
//                             S.current.apartment,
//                             // focusNode: apartmentNode,
//                             // onlyNumber: true,
//                             validator: (p0) {
//                               if (p0!.length == 0)
//                                 return S.current.thisFieldIsRequired;

//                               return null;
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                     //
//                     setHeightSpace(30),
//                     //
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.7,
//                       child: globalButton(
//                         S.current.saveAddress,
//                         () async {
//                           FocusScope.of(context).unfocus();
//                           if (v.theLocation.latitude == 0) {
//                             var res = await chooseYesNoDialog(
//                               context,
//                               S.current.pleaseSelectLocation,
//                               yesText: S.current.select,
//                               noText: S.current.skip,
//                             );
//                             if (res != null && res['choose']) selectLocation();
//                             return;
//                           }
//                           //
//                           if (formKey.currentState!.validate()) {
//                             loadingDialog(context);
//                             v2.saveAddress({
//                               // 'nick_name': name.text,
//                               'location': addressText.text,
//                               'lat': v.theLocation.latitude.toString(),
//                               'long': v.theLocation.longitude.toString(),
//                               'building_num': building.text,
//                               'appartment_num': apartment.text,
//                               // 'street': street.text,
//                               // 'note': note.text,
//                             }).then((value) {
//                               NavMove.closeDialog(context);
//                               if (value)
//                                 NavMove.goBack(context, data: {'saved': true});
//                             });
//                             // } else {
//                             //   screenMessage(
//                             //       S.current.pleaseThereIsaRequiredField,
//                             //       color: hexToColor('#C00202'));
//                           }
//                         },
//                         borderColor: AppColor.orange,
//                         textColor: AppColor.orange,
//                         backColor: Colors.transparent,
//                       ),
//                     ),
//                     //
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   selectLocation() async {
//     locationProvider.getLocation();
//     var navRes = await NavMove.goToPage(
//         context, NewLocationSelect(text: S.current.locationHere));

//     if (navRes != null && navRes['location_selected']) {
//       setState(() {
//         locationProvider.theLocation =
//             LatLng(navRes['latitude'], navRes['longitude']);
//         locationProvider.placemarks.first = navRes['placemark'];

//         locationProvider.markers[MarkerId('location')] = Marker(
//           markerId: MarkerId('location'),
//           position: locationProvider.theLocation,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//         );

//         locationProvider.animateTo(locationProvider.theLocation.latitude,
//             locationProvider.theLocation.longitude);

//         addressText.text = navRes['location_name'];
//       });
//     }
//   }
// }
