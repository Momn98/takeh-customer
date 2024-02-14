// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';
// import 'package:takeh_customer/Global/ChooseYesNo.dart';
// import 'package:takeh_customer/Models/Address.dart';
// import 'package:takeh_customer/Provider/AddressProvider.dart';
// import 'package:takeh_customer/Shared/Constant.dart';
// import 'package:takeh_customer/Shared/Globals.dart';
// import 'package:takeh_customer/Shared/NavMove.dart';
// import 'package:takeh_customer/Shared/i18n.dart';

// class AddressCard extends StatelessWidget {
//   final Address address;
//   final bool withCheck;

//   const AddressCard({
//     Key? key,
//     required this.address,
//     this.withCheck = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AddressProvider>(
//       builder: (_, v, __) {
//         return InkWell(
//           onTap: () {
//             v.setSelectedAddress(address);
//             NavMove.goBack(context);
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//             margin: EdgeInsets.only(bottom: 10),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//                 color: v.selectedAddress.id == address.id
//                     ? AppColor.orange
//                     : Colors.grey.shade300,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 setWithSpace(5),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // globalText(
//                       //   address.name.length > 0
//                       //       ? address.name
//                       //       : S.current.other,
//                       // ),
//                       setHeightSpace(5),
//                       globalText(address.location),
//                     ],
//                   ),
//                 ),
//                 setWithSpace(5),
//                 InkWell(
//                   onTap: () async {
//                     var popRes = await chooseYesNoDialog(
//                       context,
//                       S.current.doYouWantToDeleteThisAddress,
//                       yesText: S.current.delete,
//                       noText: S.current.cancel,
//                     );
//                     if (popRes != null && popRes['choose'])
//                       await v.delete(address);
//                   },
//                   child: Image(
//                     image: GlobalImage.delete,
//                     color: Colors.red,
//                     width: 20,
//                     height: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
