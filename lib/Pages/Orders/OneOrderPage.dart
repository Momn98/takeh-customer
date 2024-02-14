import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';
import 'package:takeh_customer/Global/selectImagePopUp.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Models/Appimage.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Models/Answer.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class OneOrderPage extends StatefulWidget {
  final bool fromActive;
  const OneOrderPage({super.key, this.fromActive = false});
  @override
  State<OneOrderPage> createState() => _OneOrderPageState();
}

class _OneOrderPageState extends State<OneOrderPage> {
  @override
  void initState() {
    orderProvider.linkToOrder(context);

    locationProvider.getLocation(context);

    super.initState();
  }

  @override
  void dispose() {
    orderProvider.order = Order();
    locationProvider.controller = Completer();

    orderProvider.changePageStatus(orderProvider.status);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return GlobalSafeArea(
          horizontal: 0,
          vertical: 0,
          appBar: HomeAppBar(text: '${S.current.order} #${v.order.slug} '),
          body: Stack(
            children: [
              if (v.order.status.id == 2) ...[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Center(
                        child: globalText(
                          '${S.current.findingTheBestServiceProvider} ...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        height: [2].contains(v.order.status.id) ? 510 : 550,
                        child: Stack(
                          children: [
                            Consumer<LocationProvider>(
                              builder: (_, v, __) {
                                if (!v.haveLocation) return Container();
                                return Stack(
                                  children: [
                                    MapPicker(
                                      iconWidget: Image(
                                        image: IconSvg.location,
                                        height: 90,
                                      ),
                                      mapPickerController:
                                          v.mapPickerController,
                                      child: GoogleMap(
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                        mapType: MapType.normal,
                                        initialCameraPosition: v.position,
                                        markers:
                                            Set<Marker>.from(v.markers.values),
                                        polylines: Set<Polyline>.of(
                                            v.polylines.values),

                                        tiltGesturesEnabled: true,
                                        zoomGesturesEnabled: true,
                                        rotateGesturesEnabled: true,
                                        scrollGesturesEnabled: true,
                                        // myLocationEnabled: false,
                                        zoomControlsEnabled: true,

                                        onMapCreated:
                                            (GoogleMapController con) {
                                          v.controller.complete(con);

                                          v.animateTo(
                                              v.position.target.latitude,
                                              v.position.target.longitude);
                                        },
                                        onCameraMoveStarted: () {
                                          //
                                        },
                                        onCameraMove: (cameraPosition) {
                                          v.position = cameraPosition;
                                        },
                                      ),
                                    ),
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 3, sigmaY: 3),
                                      child: Container(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if ([3, 4, 5, 6]
                  .contains(orderProvider.order.status.id)) ...[
                Consumer<LocationProvider>(
                  builder: (_, v, __) {
                    if (!v.haveLocation) return Container();
                    return Positioned(
                      top: 0,
                      bottom: MediaQuery.of(context).size.height * 0.25,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          initialCameraPosition: v.position,
                          markers: Set<Marker>.from(v.markers.values),
                          polylines: Set<Polyline>.of(v.polylines.values),

                          tiltGesturesEnabled: true,
                          zoomGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          // myLocationEnabled: false,
                          zoomControlsEnabled: true,

                          onMapCreated: (GoogleMapController con) {
                            v.controller.complete(con);

                            v.animateTo(v.position.target.latitude,
                                v.position.target.longitude);
                          },
                          onCameraMoveStarted: () {
                            //
                          },
                          onCameraMove: (cameraPosition) {
                            v.position = cameraPosition;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],

              //

              DraggableScrollableSheet(
                initialChildSize: [2].contains(v.order.status.id)
                    ? 0.25
                    : v.order.status.id == 7
                        ? 1
                        : 0.39,
                minChildSize: [2].contains(v.order.status.id)
                    ? 0.2
                    : v.order.status.id == 7
                        ? 1
                        : 0.39,
                maxChildSize: [2].contains(v.order.status.id)
                    ? 0.3
                    : v.order.status.id == 7
                        ? 1
                        : 0.57,
                builder: (context, scrollController) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 8,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(),
                        if ([8].contains(v.order.status.id)) ...[
                          Center(
                            child: Icon(Icons.arrow_downward_outlined),
                          ),
                        ],
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                if ([1, 2, 3].contains(v.order.status.id)) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      setWithSpace(70),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: globalButton(
                                          S.current.cancel,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          () => confirmCanseleOrder(context),
                                          backColor: Colors.transparent,
                                          textColor: Colors.red,
                                          borderColor: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (v.order.category.slug
                                        .contains('car-info') &&
                                    v.order.service_provider.id > 0) ...[
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          child: Center(
                                            child: Text(
                                              '${v.order.service_provider.sp.car_type} ${v.order.service_provider.sp.car_model}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        setHeightSpace(5),
                                        Center(
                                          child: Row(
                                            children: [
                                              setWithSpace(80),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.19,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    '${v.order.service_provider.sp.car_color}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    '${v.order.service_provider.sp.car_number}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        setHeightSpace(10),
                                      ],
                                    ),
                                  ),
                                ],

                                setHeightSpace(5),
                                if (v.order.service_provider.id > 0) ...[
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  setWithSpace(30),
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        hexToColor('#FFD84E'),
                                                    child:
                                                        v.order.service_provider
                                                                    .image !=
                                                                ''
                                                            ? NetworkImagePlace(
                                                                image: v
                                                                    .order
                                                                    .service_provider
                                                                    .image,
                                                                fit:
                                                                    BoxFit.fill,
                                                                all: 90.0,
                                                              )
                                                            : Icon(
                                                                Icons.person),
                                                  ),
                                                  setWithSpace(10),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 20),
                                                    child: Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: RatingBar.builder(
                                                        ignoreGestures: true,
                                                        initialRating: v
                                                            .order
                                                            .service_provider
                                                            .rate,
                                                        allowHalfRating: true,
                                                        itemCount: 1,
                                                        itemSize: 15,
                                                        onRatingUpdate:
                                                            (rating) => null,
                                                        itemBuilder: (context,
                                                                _) =>
                                                            Icon(Icons.star,
                                                                color: Colors
                                                                    .amber),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 17),
                                                    child: Text(
                                                        '${v.order.service_provider.rate.toStringAsFixed(2)}'),
                                                  ),
                                                  setWithSpace(60),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          // ignore: deprecated_member_use
                                                          launch(
                                                              'tel:${v.order.service_provider.phone}');
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5), // Shadow color with opacity
                                                                spreadRadius:
                                                                    2, // Spread radius
                                                                blurRadius:
                                                                    7, // Blur radius
                                                                offset: Offset(
                                                                    0,
                                                                    3), // changes position of shadow
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90),
                                                            color: Colors.white,
                                                          ),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      setWithSpace(10),
                                                      InkWell(
                                                        onTap: () async {
                                                          WhatsAppUnilink link =
                                                              WhatsAppUnilink(
                                                            phoneNumber: v
                                                                .order
                                                                .service_provider
                                                                .phone,
                                                          );
                                                          // ignore: deprecated_member_use
                                                          await launch('$link');
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 2,
                                                                blurRadius: 7,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        90),
                                                            color: Colors.white,
                                                          ),
                                                          child: Icon(
                                                            Icons.chat_outlined,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  setHeightSpace(12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      globalText(
                                        v.order.service_provider.lastName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      setWithSpace(4),
                                      globalText(
                                        v.order.service_provider.firstName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  setHeightSpace(10)
                                ],

                                if (v.order.status.id == 7) ...[
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          globalText(
                                            v.order.status.name,
                                            style: TextStyle(
                                              color: v.order.status.color,
                                            ),
                                          ),
                                          setHeightSpace(10),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              globalText(
                                                widget.fromActive
                                                    ? "${v.order.remain_balance.toStringAsFixed(2)} ${S.current.jd}"
                                                    : "${v.order.price.toStringAsFixed(2)} ${S.current.jd}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              setWithSpace(5),
                                              globalText(
                                                v.order.service_provider.sp
                                                    .country.symbol,
                                              ),
                                            ],
                                          ),
                                          Divider(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              globalText(
                                                "${v.order.duration.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              setWithSpace(5),
                                              globalText(S.current.min),
                                            ],
                                          ),
                                          setHeightSpace(5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              globalText(
                                                "${v.order.distance.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              setWithSpace(5),
                                              globalText(S.current.km),
                                            ],
                                          ),
                                          Divider(),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 3,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 15),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: Icon(
                                                        Icons.discount,
                                                        color: Colors.green),
                                                    title: globalText(
                                                      '${S.current.discountedAmount}: ${v.order.discounted_amount.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: Icon(
                                                        Icons.money_off,
                                                        color: Colors.red),
                                                    title: globalText(
                                                      '${S.current.paidCash}: ${v.order.paid_cash.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    dense: true,
                                                  ),
                                                  Divider(),
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: Icon(
                                                        Icons
                                                            .account_balance_wallet,
                                                        color: Colors.blue),
                                                    title: globalText(
                                                      '${S.current.paidWallet}: ${v.order.paid_wallet.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    dense: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],

                                if (![1, 2].contains(v.order.status.id)) ...[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: v.order.answers.length,
                                    itemBuilder: (context, index) {
                                      Answer answer = v.order.answers[index];

                                      if (answer.type == 'date-time')
                                        return Container();

                                      return Card(
                                        surfaceTintColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (answer.type != 'slider' &&
                                                  answer.type !=
                                                      'from-to-address' &&
                                                  answer.type != 'options')
                                                globalText(
                                                  answer.question.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              //
                                              //
                                              // if (answer.type ==
                                              //     'options') // // //
                                              //   OptionWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'slider') // // //
                                                SliderWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'images') // // //
                                                ImagesWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'input') // // //
                                                InputWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'address') // // //
                                                AddressWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'from-to-address') // // //
                                                FromToAddressWidgitCard(answer),
                                              //
                                              //
                                              if (answer.type ==
                                                  'date-time') // // //
                                                DateTimeWidgitCard(answer),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],

                                setHeightSpace(20),
                                //
                                if (v.order.status.id == 2) ...[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: globalText(
                                      S.current.Lookingforadriver,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                    minHeight: 2,
                                  ),
                                  SizedBox(height: 20),
                                ],
                                if ([7, 8, 9].contains(v.order.status.id)) ...[
                                  Container(
                                    width: double.infinity,
                                    child: globalButton(
                                      S.current.back,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      () {
                                        NavMove.goBack(context);
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  confirmCanseleOrder(BuildContext context, {String? extraText}) async {
    orderProvider.cancelReason = '';
    orderProvider.other = false;
    orderProvider.otherReason = TextEditingController();

    var res = await chooseYesNoDialog(
      context,
      S.current.confirmCancelOrder,
      extraText: extraText,
      extraStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      widgets: [
        Consumer<OrderProvider>(
          builder: (_, v, __) {
            return Column(
              children: [
                canselReasonButton(S.current.reason1),
                canselReasonButton(S.current.reason2),
                canselReasonButton(S.current.reason3),
                canselReasonButton(S.current.reason4),
                canselReasonButton(S.current.reason5),
                setHeightSpace(10),
                Row(
                  children: [
                    globalButton(
                      S.current.other,
                      () {
                        v.cancelReason = '';
                        v.other = true;
                      },
                      backColor: v.other ? AppColor.orange : Colors.transparent,
                      textColor: !v.other ? AppColor.orange : Colors.white,
                      borderColor: !v.other ? AppColor.orange : Colors.white,
                    ),
                    setWithSpace(10),
                    if (v.other)
                      Expanded(
                        child: authTextFiled(
                          v.otherReason,
                          hint: S.current.cancelReason,
                          onChanged: (p0) {
                            v.cancelReason = p0;
                          },
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );

    if (res == null) return;

    if (orderProvider.cancelReason == '') {
      return confirmCanseleOrder(context,
          extraText: S.current.thisFieldIsRequired);
    }

    await orderProvider.changeOrderStatus(
        context, 8, orderProvider.cancelReason);

    // orderProvider.order = Order();

    if (!mounted) return;
    try {
      locationProvider.clearMarker();
    } catch (e) {}
    try {
      locationProvider.clearPolylines();
    } catch (e) {}
    setState(() {});
  }

  Widget canselReasonButton(String reason) {
    return InkWell(
      onTap: () {
        orderProvider.cancelReason = reason;
        orderProvider.other = false;
        orderProvider.otherReason = TextEditingController();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Radio(
                value: reason,
                groupValue: orderProvider.cancelReason,
                onChanged: (value) {
                  if (value != null) {
                    orderProvider.cancelReason = reason;
                    orderProvider.other = false;
                    orderProvider.otherReason = TextEditingController();
                  }
                },
              ),
            ),
            Expanded(child: globalText(reason)),
          ],
        ),
      ),
    );
  }

//
}

// class OptionWidgitCard extends StatefulWidget {
//   final Answer answer;
//   const OptionWidgitCard(this.answer, {super.key});

//   @override
//   State<OptionWidgitCard> createState() => _OptionWidgitCardState();
// }

// class _OptionWidgitCardState extends State<OptionWidgitCard> {
//   late Answer answer;

//   @override
//   void initState() {
//     answer = widget.answer;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: answer.question.height,
//       child: Row(
//         children: [
//           if (answer.option.image.length > 0) ...[
//             Expanded(
//               child: NetworkImagePlace(
//                 image: answer.option.image,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             setWithSpace(10),
//           ],
//           Expanded(
//             flex: 2,
//             child: globalText(
//               answer.option.name,
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SliderWidgitCard extends StatefulWidget {
  final Answer answer;
  const SliderWidgitCard(this.answer, {super.key});

  @override
  State<SliderWidgitCard> createState() => _SliderWidgitCardState();
}

class _SliderWidgitCardState extends State<SliderWidgitCard> {
  late Answer answer;
  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        globalText(
          "${answer.question.name}: ${answer.answer}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        setHeightSpace(10),
        // Slider(
        //   thumbColor: Colors.grey,
        //   activeColor: Colors.grey,
        //   inactiveColor: Colors.grey.shade300,
        //   min: answer.question.min.toDouble(),
        //   max: answer.question.max.toDouble(),
        //   value: double.parse(answer.answer),
        //   onChanged: (value) => null,
        // ),
      ],
    );
  }
}

class ImagesWidgitCard extends StatefulWidget {
  final Answer answer;
  const ImagesWidgitCard(this.answer, {super.key});

  @override
  State<ImagesWidgitCard> createState() => _ImagesWidgitCardState();
}

class _ImagesWidgitCardState extends State<ImagesWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
        ),
        itemCount: answer.images.length,
        itemBuilder: (context, index) {
          Appimage image = answer.images[index];

          return InkWell(
            onTap: () => NavMove.goToPage(
                context, ImageShowPage(image.image, index: index)),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: index == 0 ? AppColor.secondary : AppColor.orange,
                  width: index == 0 ? 2 : 1,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Center(child: Image.network(image.image)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputWidgitCard extends StatefulWidget {
  final Answer answer;
  const InputWidgitCard(this.answer, {super.key});

  @override
  State<InputWidgitCard> createState() => _InputWidgitCardState();
}

class _InputWidgitCardState extends State<InputWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: TextEditingController(text: answer.answer),
          enabled: false,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          style: TextStyle(overflow: TextOverflow.visible),
          scrollPadding: EdgeInsets.all(5),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: border(AppColor.secondary),
            fillColor: Colors.white,
            alignLabelWithHint: true,
            hintMaxLines: 2,
            filled: true,
          ),
        ),
        setHeightSpace(10),
      ],
    );
  }
}

class AddressWidgitCard extends StatefulWidget {
  final Answer answer;
  const AddressWidgitCard(this.answer, {Key? key}) : super(key: key);
  @override
  State<AddressWidgitCard> createState() => _AddressWidgitCardState();
}

class _AddressWidgitCardState extends State<AddressWidgitCard> {
  late Answer answer;
  Completer<GoogleMapController> controller = Completer();
  late CameraPosition cameraPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> animateTo(double lat, double lng) async {
    final c = await controller.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: cameraPosition.zoom,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  @override
  void initState() {
    answer = widget.answer;
    cameraPosition = CameraPosition(
      target: LatLng(orderProvider.order.from_address.latitude,
          orderProvider.order.from_address.longitude),
      zoom: 17,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        setHeightSpace(10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: IconSvg.address_from,
                  width: 15,
                  height: 15,
                ),
                setWithSpace(5),
                Expanded(
                    child:
                        globalText(orderProvider.order.from_address.location)),
                setWithSpace(5),
                Container(
                  child: Image(image: IconSvg.location),
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        setHeightSpace(5),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                scrollGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: cameraPosition,
                markers: Set<Marker>.from(markers.values),
                onMapCreated: (GoogleMapController con) {
                  controller.complete(con);

                  markers[MarkerId(
                          'location-${orderProvider.order.from_address.id}')] =
                      Marker(
                    markerId: MarkerId(
                        'location-${orderProvider.order.from_address.id}'),
                    position: LatLng(
                      orderProvider.order.from_address.latitude,
                      orderProvider.order.from_address.longitude,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange),
                  );

                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FromToAddressWidgitCard extends StatefulWidget {
  final Answer answer;
  const FromToAddressWidgitCard(this.answer, {super.key});

  @override
  State<FromToAddressWidgitCard> createState() =>
      _FromToAddressWidgitCardState();
}

class _FromToAddressWidgitCardState extends State<FromToAddressWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            String googleUrl =
                'https://www.google.com/maps/search/?api=1&query=${orderProvider.order.from_address.latitude},${orderProvider.order.from_address.longitude}';
            // ignore: deprecated_member_use
            await launch(googleUrl);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.black),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: IconSvg.address_from,
                    width: 15,
                    height: 15,
                  ),
                  setWithSpace(5),
                  Expanded(
                    child: globalText(
                      orderProvider.order.from_address.location,
                      maxLines: 1,
                    ),
                  ),
                  setWithSpace(5),
                  Container(
                    child: Image(image: IconSvg.location),
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),

        //

        InkWell(
          onTap: () async {
            String googleUrl =
                'https://www.google.com/maps/search/?api=1&query=${orderProvider.order.to_address.latitude},${orderProvider.order.to_address.longitude}';
            // ignore: deprecated_member_use
            await launch(googleUrl);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.black),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    child: IconSvg.address_to,
                    width: 15,
                    height: 15,
                  ),
                  setWithSpace(5),
                  Expanded(
                    child: globalText(
                      orderProvider.order.to_address.location,
                      maxLines: 1,
                    ),
                  ),
                  setWithSpace(5),
                  Container(
                    child: Image(image: IconSvg.location),
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimeWidgitCard extends StatefulWidget {
  final Answer answer;
  const DateTimeWidgitCard(this.answer, {super.key});

  @override
  State<DateTimeWidgitCard> createState() => _DateTimeWidgitCardState();
}

class _DateTimeWidgitCardState extends State<DateTimeWidgitCard> {
  late Answer answer;

  @override
  void initState() {
    answer = widget.answer;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: double.infinity),
        // setHeightSpace(10),
        globalText(
          "${S.current.time}: ${answer.answer}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        setHeightSpace(10),
      ],
    );
  }
}
