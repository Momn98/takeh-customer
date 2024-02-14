// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:takeh_customer/Models/Address.dart';
// import 'package:takeh_customer/Pages/Auth/AuthView.dart';
// import 'package:takeh_customer/Pages/Locations/Components/AddressCard.dart';
// import 'package:takeh_customer/Pages/Locations/Layout/AddAddress.dart';
// import 'package:takeh_customer/Provider/AddressProvider.dart';
// import 'package:takeh_customer/Shared/Constant.dart';
// import 'package:takeh_customer/Shared/Globals.dart';
// import 'package:takeh_customer/Shared/NavMove.dart';
// import 'package:takeh_customer/Shared/i18n.dart';
// import 'package:takeh_customer/main.dart';

// addressBottomUpSheet(BuildContext context) async {
//   if (addressProvider.address.length == 0) {
//     var res = await NavMove.goToPage(context, AddAddress());
//     if (res == null || !res['saved']) return;
//   }

//   if (addressProvider.address.length == 1)
//     addressProvider.setSelectedAddress(addressProvider.address.first);

//   return await showModalBottomSheet(
//     enableDrag: true,
//     isScrollControlled: true,
//     context: context,
//     builder: (BuildContext context) {
//       // SafeArea
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Consumer<AddressProvider>(
//             builder: (context, val, child) {
//               return Container(
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 color: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: globalText(
//                               S.current.address,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => NavMove.goBack(context),
//                             child: Icon(
//                               Icons.check,
//                               color: Colors.green,
//                               size: 30,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     setHeightSpace(20),

//                     Expanded(
//                       child: SingleChildScrollView(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           children: [
//                             if (val.address.length > 0)
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: ScrollPhysics(),
//                                 itemCount: val.address.length,
//                                 itemBuilder: (context, index) {
//                                   Address address = val.address[index];
//                                   return AddressCard(address: address);
//                                 },
//                               )
//                             else ...[
//                               setHeightSpace(50),
//                               globalText(
//                                 S.current.youDontHaveAnySavedAddress,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               Divider(),
//                             ],
//                             setHeightSpace(20),
//                           ],
//                         ),
//                       ),
//                     ),
//                     //
//                     setHeightSpace(10),

//                     InkWell(
//                       onTap: () {
//                         if (!authProvider.isLogIn)
//                           return NavMove.goToPage(context, AuthView());
//                         //
//                         NavMove.goToPage(context, AddAddress());
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.add, color: AppColor.orange),
//                           globalText(
//                             S.current.addNewAddress,
//                             style: TextStyle(
//                                 // color: AppColor.primary,
//                                 // fontSize: 22,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     setHeightSpace(10),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }
