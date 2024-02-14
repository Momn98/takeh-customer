import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Models/Question.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Models/Option.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreateOrderMultiStepTwo extends StatefulWidget {
  const CreateOrderMultiStepTwo({super.key});
  @override
  State<CreateOrderMultiStepTwo> createState() =>
      _CreateOrderMultiStepTwoState();
}

class _CreateOrderMultiStepTwoState extends State<CreateOrderMultiStepTwo> {
  @override
  void initState() {
    orderProvider.getDistance(
      fromlat: orderProvider.fromlatitude,
      fromlong: orderProvider.fromlongitude,
      tolat: orderProvider.tolatitude,
      tolong: orderProvider.tolongitude,
    );
    super.initState();
  }

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
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
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

              DraggableScrollableSheet(
                initialChildSize: 0.50,
                minChildSize: 0.50,
                maxChildSize: 0.72,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: v.category.questions.length,
                          itemBuilder: (context, index) {
                            Question question = v.category.questions[index];

                            if (question.type == 'options')
                              return OptionWidgitCard(question);

                            return Container();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomBar(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black26, blurRadius: 15, offset: Offset(0, -1))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildTextIconButton(
                  orderProvider.paymentType.text,
                  Icons.payment,
                  Icons.arrow_drop_down,
                  () {
                    setState(() {
                      if (orderProvider.paymentType.text == 'Cash') {
                        if (authProvider.user.wallet >= 1) {
                          orderProvider.paymentType.text = 'wallet';
                        } else {
                          screenMessage(S.current.moneyInWalletNotEnough);
                        }
                      } else {
                        orderProvider.paymentType.text = 'cash';
                      }
                    });
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: orderProvider.promoCodeController,
                  decoration: InputDecoration(
                    labelText: S.current.promoCode,
                    suffixIcon: IconButton(
                      icon: Icon(orderProvider.showPromo
                          ? Icons.cancel
                          : Icons.check_circle),
                      onPressed: () {
                        orderProvider.checkPromoCode(context);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildYallaButton(orderProvider),
        ],
      ),
    );
  }

  Widget _buildYallaButton(OrderProvider orderProvider) {
    return Consumer<OrderProvider>(
      builder: (BuildContext context, v, Widget? child) {
        return ElevatedButton(
          onPressed: () async {
            // orderProvider.submitOrder(context);
            for (Map ans in v.answers) {
              if (ans['is_req']) {
                if (!ans['is_good']) {
                  Question errorQuestion = v.category.questions
                      .firstWhere((e) => e.id == ans['question_id']);

                  return screenMessage(errorQuestion.error);
                }
              }
            }

            await v.calFullPrice();

            var res = await chooseYesNoDialog(
              context,
              S.current.submitYourOrder,
              extraText:
                  '${S.current.orderPrice} (${(v.finalPrice).toStringAsFixed(2)} - ${(v.finalPrice + 0.5).toStringAsFixed(2)})${S.current.jd}',
            );

            if (res == null) return;

            v.submitOrder(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.orange,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 12),
            minimumSize: Size(double.infinity, 48),
          ),
          child: Text(
            S.current.YALLA,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextIconButton(
      String title, IconData icon, IconData arrowIcon, VoidCallback onPressed) {
    return TextButton.icon(
      icon: Icon(icon, size: 20, color: Colors.green),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Icon(arrowIcon, size: 20, color: Colors.black),
        ],
      ),
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(150, 50),
        padding: EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), side: BorderSide.none),
      ),
    );
  }
}

class OptionWidgitCard extends StatefulWidget {
  final Question question;
  const OptionWidgitCard(this.question, {Key? key}) : super(key: key);
  @override
  State<OptionWidgitCard> createState() => _OptionWidgetCardState();
}

class _OptionWidgetCardState extends State<OptionWidgitCard> {
  late Question question;
  int selectedOption = 0;
  int questionIndex = 0;
  String selectedTime = "Now";

  @override
  void initState() {
    super.initState();
    question = widget.question;
    questionIndex = orderProvider.answersIndex(question.id);
    selectedOption = question.options.first.id;
    orderProvider.answers[questionIndex].addAll({
      'answer': selectedOption,
      'price': question.options.first.price,
      'extra_price': question.options.first.extra_price,
      'is_good': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (_, v, __) {
      return Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ...question.options.map((Option option) {
              bool isSelected = selectedOption == option.id;

              double thePrice = orderProvider.timeCost +
                  option.price +
                  (option.extra_price * orderProvider.answers[1]['distanse']);
              return InkWell(
                onTap: () {
                  printLog("thePrice $thePrice");
                  setState(() {
                    selectedOption = option.id;
                    orderProvider.updateOnAnswers(questionIndex, {
                      'answer': option.id,
                      'is_good': true,
                      'price': option.price,
                      'extra_price': option.extra_price,
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.secondary.withAlpha(12)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        option.image,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          children: [
                            Text(
                              "JOD ${(v.final_price(thePrice)).toStringAsFixed(2)} - ${(0.5 + v.final_price(thePrice)).toStringAsFixed(2)}",
                            ),
                            Text(
                              "${option.extra_price.toStringAsFixed(2)} /KM",
                            )
                          ],
                        ),
                      ),
                      isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      );
    });
  }
}
