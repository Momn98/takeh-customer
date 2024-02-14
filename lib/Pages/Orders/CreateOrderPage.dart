import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Global/selectImagePopUp.dart';
import 'package:takeh_customer/Models/Option.dart';
import 'package:takeh_customer/Models/Question.dart';
import 'package:takeh_customer/Pages/Locations/new_location.dart';
import 'package:takeh_customer/Pages/Orders/addAddressPopUp.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});
  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  void initState() {
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
        'distanse': 0.0,
      });
    }

    Timer(Duration(seconds: 1), () {
      orderProvider.calFullPrice();
    });

    super.initState();
  }

  double top = 0.0;
  bool reachMax = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderProvider, LocationProvider>(
      builder: (_, v, v2, __) {
        return GlobalSafeArea(
          horizontal: 0,
          vertical: 0,
          appBar: HomeAppBar(text: v.category.name),
          body: Stack(
            children: [
              //
              if (v2.haveLocation)
                Positioned(
                  top: 0,
                  // bottom: 0,
                  bottom: MediaQuery.of(context).size.height * 0.35,
                  left: 0,
                  right: 0,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: v2.position,
                    markers: Set<Marker>.from(v2.markers.values),
                    onMapCreated: (GoogleMapController controller) {
                      try {
                        v2.controller.complete(controller);
                      } catch (e) {}

                      v2.animateTo(v2.position.target.latitude,
                          v2.position.target.longitude);

                      homeProvider.getNearLocations(
                          v2.position.target.latitude,
                          v2.position.target.longitude,
                          orderProvider.category.id);
                      setState(() {});
                    },
                  ),
                ),

              //

              DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                maxChildSize: 0.85,
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: v.category.questions.length,
                                  itemBuilder: (context, index) {
                                    Question question =
                                        v.category.questions[index];

                                    return Card(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (question.type != 'slider' &&
                                                question.type != 'date-time')
                                              globalText(
                                                question.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            //
                                            // setHeightSpace(5),
                                            // globalText('type: ${question.price_type}'),
                                            // globalText('val: ${question.val}'),
                                            // setHeightSpace(5),
                                            //
                                            if (question.type == 'options')
                                              OptionWidgitCard(question),
                                            //
                                            //
                                            if (question.type == 'slider')
                                              SliderWidgitCard(question),
                                            //
                                            //
                                            if (question.type == 'images')
                                              ImagesWidgitCard(question),
                                            //
                                            //
                                            if (question.type == 'input')
                                              InputWidgitCard(question),
                                            //
                                            //
                                            if (question.type == 'address')
                                              AddressWidgitCard(question),
                                            //
                                            //
                                            if (question.type ==
                                                'from-to-address')
                                              FromToAddressWidgitCard(question),
                                            //
                                            //
                                            if (question.type == 'date-time')
                                              DateTimeWidgitCard(question),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                //
                                setHeightSpace(20),
                                //

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: textFiled(v.promoCodeController,
                                          label: S.current.promoCode,
                                          enabled: !v.showPromo,
                                          onEditingComplete: () {
                                        print(v.promoCodeController.text);
                                      }),
                                    ),
                                    setWithSpace(5),
                                    InkWell(
                                      onTap: () {
                                        v.checkPromoCode(context);
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: !v.showPromo
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        child: Text(
                                          !v.showPromo
                                              ? S.current.apply
                                              : S.current.change,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                setHeightSpace(15),

                                PopupMenuButton(
                                  offset: Offset(0, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: textFiled(
                                    v.paymentType,
                                    label: S.current.paymentType,
                                    enabled: false,
                                    labelColor: Colors.black,
                                  ),
                                  onSelected: (value) {
                                    if (value == 'wallet') {
                                      if (authProvider.user.wallet < 1) {
                                        return screenMessage(
                                            S.current.moneyInWalletNotEnough);
                                      }
                                    }
                                    setState(() => v.paymentType.text = value);
                                  },
                                  itemBuilder: (ctx) => [
                                    popUp(context, S.current.cash,
                                        value: 'cash'),
                                    //
                                    popUp(context, S.current.wallet,
                                        value: 'wallet'),
                                  ],
                                ),

                                setHeightSpace(25),

                                Container(
                                  width: double.infinity,
                                  child: globalButton(
                                    S.current.submit,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    () async {
                                      for (Map ans in v.answers) {
                                        if (ans['is_req']) {
                                          if (!ans['is_good']) {
                                            Question errorQuestion = v
                                                .category.questions
                                                .firstWhere((e) =>
                                                    e.id == ans['question_id']);

                                            return screenMessage(
                                                errorQuestion.error);
                                          }
                                        }
                                      }

                                      v.calFullPrice();

                                      var res = await chooseYesNoDialog(
                                        context,
                                        S.current.submitYourOrder,
                                        extraText:
                                            '${S.current.orderPrice} (${(v.finalPrice - 0.50).toStringAsFixed(2)} - ${v.finalPrice})${S.current.jd}',
                                      );

                                      if (res == null) return;

                                      v.submitOrder(context);
                                    },
                                  ),
                                ),

                                // setHeightSpace(5),
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

  PopupMenuItem popUp(BuildContext ctx, String title,
      {var value, int quarterTurns = 0}) {
    return PopupMenuItem(
      value: value,
      child: Container(
        height: kMinInteractiveDimension,
        child: globalText(title),
      ),
    );
  }
}

class OptionWidgitCard extends StatefulWidget {
  final Question question;
  const OptionWidgitCard(this.question, {super.key});

  @override
  State<OptionWidgitCard> createState() => _OptionWidgitCardState();
}

class _OptionWidgitCardState extends State<OptionWidgitCard> {
  late Question question;
  int selectedOption = 0;
  int questionIndex = 0;
  @override
  void initState() {
    question = widget.question;
    questionIndex = orderProvider.answersIndex(question.id);

    selectedOption = question.options.first.id;

    orderProvider.answers[questionIndex].addAll({
      'answer': question.options.first.id,
      'price': question.options.first.price,
      'price_type': question.price_type,
      'extra_price': question.options.first.extra_price,
      'is_good': true,
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (question.layout == 'GridView')
      return Consumer<OrderProvider>(
        builder: (_, v, __) {
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: question.inRow,
              crossAxisSpacing: 5,
              mainAxisExtent: question.height,
            ),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              Option option = question.options[index];
              return Card(
                color: selectedOption == option.id ? AppColor.orange : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedOption = option.id;

                      v.updateOnAnswers(questionIndex, {
                        'answer': option.id,
                        'is_good': true,
                        'price': option.price,
                        'extra_price': option.extra_price,
                      });
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (option.image.length > 0)
                          Expanded(
                            flex: 2,
                            child: NetworkImagePlace(
                              image: option.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        setHeightSpace(3),
                        globalText(
                          option.name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    //
    if (question.layout == 'List.row')
      return Consumer<OrderProvider>(
        builder: (_, v, __) {
          return Container(
            height: question.height,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                Option option = question.options[index];
                return Card(
                  color: selectedOption == option.id ? AppColor.orange : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedOption = option.id;

                        v.updateOnAnswers(questionIndex, {
                          'answer': option.id,
                          'is_good': true,
                          'price': option.price,
                          'extra_price': option.extra_price,
                        });
                      });
                    },
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (option.image.length > 0)
                            Expanded(
                              flex: 2,
                              child: NetworkImagePlace(
                                image: option.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          setHeightSpace(3),
                          globalText(
                            option.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    //
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: question.options.length,
          itemBuilder: (context, index) {
            Option option = question.options[index];
            return Card(
              color: selectedOption == option.id ? AppColor.orange : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedOption = option.id;

                    v.updateOnAnswers(questionIndex, {
                      'answer': option.id,
                      'is_good': true,
                      'price': option.price,
                      'extra_price': option.extra_price,
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (option.image.length > 0)
                        Expanded(
                          flex: 2,
                          child: NetworkImagePlace(
                            image: option.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      setHeightSpace(3),
                      globalText(
                        option.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SliderWidgitCard extends StatefulWidget {
  final Question question;
  const SliderWidgitCard(this.question, {super.key});
  @override
  State<SliderWidgitCard> createState() => _SliderWidgitCardState();
}

class _SliderWidgitCardState extends State<SliderWidgitCard> {
  double val = 0.0;
  late Question question;
  int questionIndex = 0;
  @override
  void initState() {
    question = widget.question;

    val = question.min_val.toDouble();
    questionIndex = orderProvider.answersIndex(question.id);

    orderProvider.answers[questionIndex].addAll({
      'answer': val,
      'is_good': true,
    });

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
            globalText(
              "${question.name}: ${val.toStringAsFixed(0)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Slider(
              min: question.min.toDouble(),
              max: question.max.toDouble(),
              divisions: question.max - question.min,
              value: val,
              onChanged: (value) {
                setState(() {
                  val = value;
                  v.updateOnAnswers(questionIndex, {
                    'answer': val,
                    'is_good': true,
                  });
                });
              },
            ),
            globalText(question.desc),
          ],
        );
      },
    );
  }
}

class ImagesWidgitCard extends StatefulWidget {
  final Question question;
  const ImagesWidgitCard(this.question, {super.key});

  @override
  State<ImagesWidgitCard> createState() => _ImagesWidgitCardState();
}

class _ImagesWidgitCardState extends State<ImagesWidgitCard> {
  late Question question;
  List<String> base64Images = [];
  List<XFile> files = [];
  int questionIndex = 0;

  @override
  void initState() {
    question = widget.question;

    questionIndex = orderProvider.answersIndex(question.id);

    orderProvider.answers[questionIndex].addAll({
      'answer': [],
      'is_good': true,
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return Container(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 100,
            ),
            itemCount: files.length + 1,
            itemBuilder: (context, index) {
              if (files.length <= index)
                return InkWell(
                  onTap: () async {
                    var res = await selectImagePopUp(context);
                    if (res != null && res['is_picked']) {
                      // List<String> base64Images = [];
                      List<XFile> fis = res['pickeds'];
                      //
                      for (XFile file in fis) {
                        List<int> imageBytes = await file.readAsBytes();
                        String base64Image = base64Encode(imageBytes);

                        files.add(file);
                        base64Images.add(base64Image);
                      }

                      v.updateOnAnswers(questionIndex, {
                        'answer': base64Images,
                        'is_good': true,
                      });

                      setState(() {});
                    }
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color:
                            index == 0 ? AppColor.secondary : AppColor.orange,
                        width: index == 0 ? 2 : 1,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: SvgPicture.asset(
                        IconSvg.add_outline,
                        // color: AppColor.orange,
                      ),
                    ),
                  ),
                );

              XFile file = files[index];

              return InkWell(
                onTap: () => NavMove.goToPage(
                    context, ImageShowPage(files, index: index)),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: index == 0 ? AppColor.secondary : AppColor.orange,
                      width: index == 0 ? 2 : 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Image.file(File(file.path)),
                        ),
                      ),
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: InkWell(
                          onTap: () async {
                            files.remove(file);

                            v.answers[questionIndex]['answer'] = [];
                            base64Images = [];
                            for (XFile file in files) {
                              List<int> imageBytes = await file.readAsBytes();
                              String base64Image = base64Encode(imageBytes);
                              base64Images.add(base64Image);
                            }

                            v.updateOnAnswers(questionIndex, {
                              'answer': base64Images,
                              'is_good': base64Images.length > 0,
                            });

                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                              IconSvg.delete_outline,
                              color: Colors.black,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class InputWidgitCard extends StatefulWidget {
  final Question question;
  const InputWidgitCard(this.question, {super.key});

  @override
  State<InputWidgitCard> createState() => _InputWidgitCardState();
}

class _InputWidgitCardState extends State<InputWidgitCard> {
  late Question question;
  TextEditingController controller = TextEditingController();
  int questionIndex = 0;

  @override
  void initState() {
    question = widget.question;

    questionIndex = orderProvider.answersIndex(question.id);
    orderProvider.answers[questionIndex].addAll({
      'controller': TextEditingController(),
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return TextFormField(
          controller: v.answers[questionIndex]['controller'],
          maxLines: question.min_val,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          onChanged: (value) {
            if (value.length > 0)
              v.answers[questionIndex]['is_good'] = true;
            else
              v.answers[questionIndex]['is_good'] = false;
          },
          validator: (val) {
            if (question.is_req && val!.length < 1)
              return S.current.thisFieldIsRequired;

            return null;
          },
          style: TextStyle(overflow: TextOverflow.visible),
          onFieldSubmitted: (value) async {},
          scrollPadding: EdgeInsets.all(5),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: border(AppColor.secondary),
            fillColor: Colors.white,
            alignLabelWithHint: true,
            hintMaxLines: 2,
            filled: true,
          ),
        );
      },
    );
  }
}

class AddressWidgitCard extends StatefulWidget {
  final Question question;
  const AddressWidgitCard(this.question, {Key? key}) : super(key: key);
  @override
  State<AddressWidgitCard> createState() => _AddressWidgitCardState();
}

class _AddressWidgitCardState extends State<AddressWidgitCard> {
  late Question question;
  late double lat;
  late double long;
  late String location;

  int questionIndex = 0;

  @override
  void initState() {
    question = widget.question;

    questionIndex = orderProvider.answersIndex(question.id);

    orderProvider.answers[questionIndex].addAll({
      'address': S.current.location,
      'address_lat': 0.0,
      'address_long': 0.0,
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

                Placemark fromPlacemark = fromRes['placemark'];
                v.answers[questionIndex]['address'] =
                    "${fromPlacemark.thoroughfare} ${fromPlacemark.subLocality}";
                v.answers[questionIndex]['address_lat'] = fromRes['latitude'];
                v.answers[questionIndex]['address_long'] = fromRes['longitude'];

                v.answers[questionIndex]['is_good'] = true;

                v.updateOnAnswers(questionIndex, {
                  'address':
                      "${fromPlacemark.thoroughfare} ${fromPlacemark.subLocality}",
                  'address_lat': fromRes['latitude'],
                  'address_long': fromRes['longitude'],
                  'is_good': true,
                  'nick_name':
                      addressRes != null ? addressRes['nick_name'] : '',
                  'street': addressRes != null ? addressRes['street'] : '',
                  'apartment':
                      addressRes != null ? addressRes['apartment'] : '',
                  'area_text':
                      addressRes != null ? addressRes['area_text'] : '',
                  'note': addressRes != null ? addressRes['note'] : '',
                });

                setState(() {});
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                          v.answers[questionIndex]['address'],
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
      },
    );
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

                v.fromlatitude = fromRes['latitude'];
                v.fromlongitude = fromRes['longitude'];

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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                          v.answers[questionIndex]['from_address'],
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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white),
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
                          v.answers[questionIndex]['to_address'],
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
      },
    );
  }
}

class DateTimeWidgitCard extends StatefulWidget {
  final Question question;
  const DateTimeWidgitCard(this.question, {super.key});

  @override
  State<DateTimeWidgitCard> createState() => _DateTimeWidgitCardState();
}

class _DateTimeWidgitCardState extends State<DateTimeWidgitCard> {
  late Question question;
  DateTime selectedDate = DateTime.now();
  String resData = '';
  int questionIndex = 0;

  String showTime(DateTime dateTime) {
    if (dateTime.hour > 12)
      return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour - 12}:${dateTime.minute} PM";
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute} AM";
  }

  @override
  void initState() {
    question = widget.question;
    resData = showTime(selectedDate);

    questionIndex = orderProvider.answersIndex(question.id);

    orderProvider.answers[questionIndex].addAll({
      'answer': resData,
      'is_good': true,
      'changed': false,
    });

    super.initState();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: EdgeInsets.only(top: 6),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (_, v, __) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(image: GlobalImage.clock, width: 25),
                  setWithSpace(10),
                  globalText(
                    question.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              setHeightSpace(5),
              InkWell(
                onTap: () {
                  _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: selectedDate,
                      // This is called when the user changes the dateTime.
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          selectedDate = newDateTime;
                          resData = showTime(newDateTime);

                          v.updateOnAnswers(questionIndex, {
                            'answer': resData,
                            'is_good': true,
                            'changed': true,
                          });
                        });
                      },
                    ),
                  );
                },
                child: globalText(
                  "${S.current.selectedDate}: $resData",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              setHeightSpace(20),
            ],
          ),
        );
      },
    );
  }
}
