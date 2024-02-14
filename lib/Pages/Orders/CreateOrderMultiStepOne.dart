import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Pages/Orders/CreateOrderMultiStepTwo.dart';
import 'package:takeh_customer/Pages/Locations/new_location.dart';
import 'package:takeh_customer/Pages/Orders/addAddressPopUp.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Models/Question.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:geocoding/geocoding.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CreateOrderMultiStepOne extends StatefulWidget {
  const CreateOrderMultiStepOne({Key? key}) : super(key: key);

  @override
  State<CreateOrderMultiStepOne> createState() =>
      _CreateOrderMultiStepOneState();
}

class _CreateOrderMultiStepOneState extends State<CreateOrderMultiStepOne> {
  Question question = Question();
  bool _isTrafficEnabled = false;

  @override
  void initState() {
    super.initState();
    orderProvider.orders = [];
    orderProvider.fromlatitude = 0.0;
    orderProvider.fromlongitude = 0.0;

    question = orderProvider.category.questions
        .firstWhere((q) => q.type == 'from-to-address');

    orderProvider.changePageStatus('history');

    orderProvider.paymentType.text = 'Cash';
    locationProvider.getLocation(context);
    locationProvider.clearMarker();
    orderProvider.answers = [];
    orderProvider.clearPrice();

    for (Question q in orderProvider.category.questions) {
      orderProvider.answers.add({
        'price_type': q.price_type,
        'question_id': q.id,
        'answer': 0,
        'type': q.type,
        'is_req': q.is_req,
        'is_good': false,
        'price': 0.0,
        'val': q.val,
        'extra_price': 0.0,
        'distance': 0.0,
      });
    }

    Timer(Duration(seconds: 1), () {
      orderProvider.calFullPrice();
    });
  }

  String showTime(DateTime dateTime) {
    if (dateTime.hour > 12)
      return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour - 12}:${dateTime.minute} PM";
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute} AM";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderProvider, LocationProvider>(
        builder: (context, v, v2, child) {
      return Scaffold(
        appBar: HomeAppBar(text: v.category.name),
        body: Stack(
          children: [
            if (v2.haveLocation)
              GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                initialCameraPosition: v2.position,
                trafficEnabled: _isTrafficEnabled,
                markers: Set<Marker>.from(v2.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  v2.controller.complete(controller);
                  v2.animateTo(v2.position.target.latitude,
                      v2.position.target.longitude);
                },
              ),
            PositionedDirectional(
              bottom: 245.0,
              start: 16.0,
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(50),
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(
                    _isTrafficEnabled ? Icons.traffic : Icons.traffic,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isTrafficEnabled = !_isTrafficEnabled;
                    });
                  },
                  splashRadius: 30,
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 140.0,
              start: 16.0,
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(50),
                child: Column(
                  children: [
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _zoomIn();
                      },
                      splashRadius: 30,
                    ),
                    IconButton(
                      iconSize: 20,
                      icon: Icon(
                        Icons.minimize,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _zoomOut();
                      },
                      splashRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 16,
              right: 16,
              child: FromToAddressWidgitCard(question),
            ),
            Positioned(
              bottom: 73,
              left: 0,
              right: 0,
              child: Container(
                height: 56,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: v.orders.length,
                  itemBuilder: (context, index) {
                    Order order = v.orders[index];
                    return Container(
                      child: InkWell(
                        onTap: () async {
                          v.fromlatitude = order.from_address.latitude;
                          v.fromlongitude = order.from_address.longitude;

                          v.updateOnAnswers(1, {
                            'from_address': order.from_address.location,
                            'from_address_lat': v.fromlatitude,
                            'from_address_long': v.fromlongitude,
                            //
                            'from_nick_name': order.from_address.nick_name,
                            'from_street': order.from_address.street,
                            'from_apartment': order.from_address.apartment,
                            'from_area_text': order.from_address.area,
                            'from_note': order.from_address.note,
                          });

                          if (v.category.slug.contains('taxi')) {
                            v.updateOnAnswers(1, {'is_good': true});
                          }

                          v.updateOnAnswers(1, {
                            'to_address': order.to_address.location,
                            'to_address_lat': v.tolatitude,
                            'to_address_long': v.tolongitude,
                            //
                            'to_nick_name': order.to_address.nick_name,
                            'to_street': order.to_address.street,
                            'to_apartment': order.to_address.apartment,
                            'to_area_text': order.to_address.area,
                            'to_note': order.to_address.note,
                            //
                            'is_good': true,
                          });

                          double dis = await locationProvider.calTheDis(
                            v.answers[1]['from_address_lat'],
                            v.answers[1]['from_address_long'],
                            v.answers[1]['to_address_lat'],
                            v.answers[1]['to_address_long'],
                          );

                          v.updateOnAnswers(1, {
                            'distanse': dis,
                          });
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.9),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            ' ${order.from_address.location.split(' ').first}..., ${order.to_address.location.split('').first}...',
                                            style: TextStyle(fontSize: 12)),
                                        // Text(order.to_address.location,
                                        //     style: TextStyle(fontSize: 13)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (v.fromlatitude == 0.0 ||
                                v.fromlongitude == 0.0) {
                              screenMessage(question.error);
                            } else {
                              NavMove.goToPage(
                                  context, CreateOrderMultiStepTwo());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.orange,
                            disabledForegroundColor:
                                Colors.amber.withOpacity(0.5).withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.amber.withOpacity(0.5).withOpacity(0.12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 13),
                            child: Text(
                              'Order Now',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _zoomIn() async {
    final GoogleMapController controller =
        await locationProvider.controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() async {
    final GoogleMapController controller =
        await locationProvider.controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }
}

class FromToAddressWidgitCard extends StatefulWidget {
  final Question question;
  const FromToAddressWidgitCard(this.question, {super.key});

  @override
  State<FromToAddressWidgitCard> createState() =>
      _FromToAddressWidgitCardState();
}

class _FromToAddressWidgitCardState extends State<FromToAddressWidgitCard> {
  late Question question;
  int questionIndex = 0;

  @override
  void initState() {
    question = widget.question;

    questionIndex = orderProvider.answersIndex(question.id);

    orderProvider.answers[questionIndex].addAll({
      'from_address': S.current.fromLocation,
      'from_address_lat': 0.0,
      'from_address_long': 0.0,
      'to_address': S.current.toLocation,
      'to_address_lat': 0.0,
      'to_address_long': 0.0,
      'is_good': false,
    });

    locationProvider.getLocation(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                var fromRes = await NavMove.goToPage(
                    context, NewLocationSelect(text: S.current.fromLocation));

                if (fromRes == null) return;

                var addressRes;
                if (question.locationType == 'location-address') {
                  v.nick_name.text =
                      v.answers[questionIndex]['nick_name'] ?? '';
                  v.street.text = v.answers[questionIndex]['street'] ?? '';
                  v.apartment.text =
                      v.answers[questionIndex]['apartment'] ?? '';
                  v.area_text.text =
                      v.answers[questionIndex]['area_text'] ?? '';
                  v.note.text = v.answers[questionIndex]['note'] ?? '';

                  setState(() {});

                  addressRes = await addAddressPopUp(context);
                  if (addressRes == null) return;
                }

                Placemark fromPlacemark = fromRes['placemark'];

                v.fromlatitude = fromRes['latitude'] + 0.0;
                v.fromlongitude = fromRes['longitude'] + 0.0;

                v.updateOnAnswers(questionIndex, {
                  'from_address':
                      "${fromPlacemark.thoroughfare} ${fromPlacemark.subLocality}",
                  'from_address_lat': fromRes['latitude'],
                  'from_address_long': fromRes['longitude'],
                  //
                  'from_nick_name':
                      addressRes != null ? addressRes['nick_name'] : '',
                  'from_street': addressRes != null ? addressRes['street'] : '',
                  'from_apartment':
                      addressRes != null ? addressRes['apartment'] : '',
                  'from_area_text':
                      addressRes != null ? addressRes['area_text'] : '',
                  'from_note': addressRes != null ? addressRes['note'] : '',
                });

                if (v.category.slug.contains('taxi')) {
                  v.updateOnAnswers(questionIndex, {'is_good': true});
                }

                double dis = await locationProvider.calTheDis(
                  v.answers[questionIndex]['from_address_lat'],
                  v.answers[questionIndex]['from_address_long'],
                  v.answers[questionIndex]['to_address_lat'],
                  v.answers[questionIndex]['to_address_long'],
                );

                v.updateOnAnswers(questionIndex, {
                  'distanse': dis,
                });

                setState(() {});
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      child: IconSvg.address_from,
                      width: 15,
                      height: 15,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: globalText(
                        v.answers[questionIndex]['from_address'] ?? "",
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      child: Image(image: IconSvg.location),
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            setHeightSpace(10),
            InkWell(
              onTap: () async {
                var fromRes = await NavMove.goToPage(
                    context, NewLocationSelect(text: S.current.toLocation));

                if (fromRes == null) return;

                var addressRes;
                if (question.locationType == 'location-address') {
                  v.nick_name.text =
                      v.answers[questionIndex]['nick_name'] ?? '';
                  v.street.text = v.answers[questionIndex]['street'] ?? '';
                  v.apartment.text =
                      v.answers[questionIndex]['apartment'] ?? '';
                  v.area_text.text =
                      v.answers[questionIndex]['area_text'] ?? '';
                  v.note.text = v.answers[questionIndex]['note'] ?? '';

                  setState(() {});

                  addressRes = await addAddressPopUp(context);
                  if (addressRes == null) return;
                }

                v.tolatitude = fromRes['latitude'];
                v.tolongitude = fromRes['longitude'];

                Placemark fromPlacemark = fromRes['placemark'];
                v.updateOnAnswers(questionIndex, {
                  'to_address':
                      "${fromPlacemark.thoroughfare} ${fromPlacemark.subLocality}",
                  'to_address_lat': fromRes['latitude'],
                  'to_address_long': fromRes['longitude'],
                  'is_good': true,
                  //
                  'to_nick_name':
                      addressRes != null ? addressRes['nick_name'] : '',
                  'to_street': addressRes != null ? addressRes['street'] : '',
                  'to_apartment':
                      addressRes != null ? addressRes['apartment'] : '',
                  'to_area_text':
                      addressRes != null ? addressRes['area_text'] : '',
                  'to_note': addressRes != null ? addressRes['note'] : '',
                });

                double dis = await locationProvider.calTheDis(
                  v.answers[questionIndex]['from_address_lat'],
                  v.answers[questionIndex]['from_address_long'],
                  v.answers[questionIndex]['to_address_lat'],
                  v.answers[questionIndex]['to_address_long'],
                );

                v.updateOnAnswers(questionIndex, {'distanse': dis});

                setState(() {});
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
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
                        v.answers[questionIndex]['to_address'] ?? "",
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
          ],
        );
      },
    );
  }
}
