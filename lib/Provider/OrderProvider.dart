import 'package:takeh_customer/Pages/Orders/OneOrderPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Global/loadingDialog.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Models/PromoCode.dart';
import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:takeh_customer/Api/OrderApi.dart';
import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:image/image.dart' as IMG;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class OrderProvider extends ChangeNotifier {
  String distance = '';
  String duration = '';
  OrderApi _api = OrderApi();
  Category category = Category();

  double distanse_far = 0.0;
  double qty = 0.0;
  double distanse = 0.0;
  double option_price = 0.0;
  double extra_price = 0.0;
  bool include_extra = true;

//

  clearPrice() {
    distanse_far = 0.0;
    qty = 0.0;
    distanse = 0.0;
    option_price = 0.0;
    extra_price = 0.0;
    include_extra = true;
  }

  double finalPrice = 0.0;

  isTimeOutRange() {
    //
    // fromTimeRange
    //

    //
    // toTimeRange
    //
  }

  Future calFullPrice() async {
    double price = 0.0;

    for (var ans in answers) {
      if (ans['val'] == 'distanse_far') {
        distanse_far = double.parse(ans['answer'].toString());
        // extra_price = double.parse(ans['extra_price'].toString());
      } else if (ans['val'] == 'qty') {
        qty = double.parse(ans['answer'].toString());
      } else if (ans['val'] == 'distanse') {
        try {
          distanse = double.parse(ans['distanse'].toString());
        } catch (e) {}
      } else if (ans['val'] == 'option_price') {
        option_price = double.parse(ans['price'].toString());
        extra_price = double.parse(ans['extra_price'].toString());
      } else if (ans['val'] == 'include_extra') {
        // extra_price = double.parse(ans['extra_price'].toString());
        include_extra = double.parse(ans['extra_price'].toString()) == 1.0;
      }

      if (ans['price_type'] == 'option_price*qty') {
        price += (option_price * qty);
      } else if (ans['price_type'] == 'extra_price*qty') {
        price += (extra_price * qty);
      } else if (ans['price_type'] == 'res+option_price') {
        price += option_price;
      } else if (ans['price_type'] == 'distanse_far*extra_price') {
        price += (distanse_far * extra_price);
        // printLog("price += (distanse_far * extra_price);");
      } else if (ans['price_type'] == 'distanse*extra_price') {
        price += (distanse * extra_price);
        // printLog("price += (distanse * extra_price);");
      } else if (ans['price_type'] == 'res+option_price+extra_price') {
        price += option_price + (include_extra ? extra_price : 0);
      }
    }

    notifyListeners();

    if (promoCode.id > 0) {
      if (promoCode.type == 'fix')
        price -= promoCode.amount;
      else if (promoCode.type == 'percentage')
        price -= (price * promoCode.amount / 100);
    }

    notifyListeners();

    await getDistance(
      fromlat: fromlatitude,
      fromlong: fromlongitude,
      tolat: tolatitude,
      tolong: tolongitude,
    ).then((value) {
      finalPrice = double.parse((price + timeCost).toStringAsFixed(2));
      notifyListeners();
    });

    return;
  }

  List<Map> answers = [];

  updateOnAnswers(int index, Map data) {
    answers[index].addAll(data);

    calFullPrice();

    notifyListeners();
  }

  int answersIndex(int id) =>
      answers.indexWhere((element) => element['question_id'] == id);

  Order order = Order();
  updateOrder(Order ord) {
    order = ord;
    notifyListeners();
  }

  updateOrderInOrders(Order ord) {
    int index = orders.indexWhere((element) => element.id == ord.id);
    if (index > -1) {
      orders[index] = ord;
      notifyListeners();
    }
  }

  GlobalKey<FormState> locationFormKey = new GlobalKey<FormState>();
  // TextEditingController location = TextEditingController();

  TextEditingController nick_name = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController apartment = TextEditingController();

  TextEditingController area_text = TextEditingController();
  TextEditingController note = TextEditingController();

  submitOrder(BuildContext context) async {
    loadingDialog(context);
    List finalData = [];

    for (Map map in answers) {
      Map loopData = {
        'question_id': map['question_id'],
        'type': map['type'],
      };

      if (map['type'] == 'input') {
        loopData.addAll({'answer': map['controller'].text}); // good
      } else if (map['type'] == 'address') {
        loopData.addAll({
          'answer': map['address'],
          'address_lat': map['address_lat'],
          'address_long': map['address_long'],
          //
          'nick_name': map['nick_name'],
          'street': map['street'],
          'apartment': map['apartment'],
          'area_text': map['area_text'],
          'note': map['note'],
        });
        //
      } else if (map['type'] == 'from-to-address') {
        //
        loopData.addAll({
          'from_answer': map['from_address'],
          'from_address_lat': map['from_address_lat'],
          'from_address_long': map['from_address_long'],

          'from_nick_name': map['from_nick_name'] ?? '',
          'from_street': map['from_street'] ?? '',
          'from_apartment': map['from_apartment'] ?? '',
          'from_area_text': map['from_area_text'] ?? '',
          'from_note': map['from_note'] ?? '',

          //
          'to_answer': map['to_address'],
          'to_address_lat': map['to_address_lat'],
          'to_address_long': map['to_address_long'],

          //
          'to_nick_name': map['to_nick_name'] ?? '',
          'to_street': map['to_street'] ?? '',
          'to_apartment': map['to_apartment'] ?? '',
          'to_area_text': map['to_area_text'] ?? '',
          'to_note': map['to_note'] ?? '',
        });
        //
      } else if (map['type'] == 'date-time') {
        loopData.addAll({
          'answer': map['answer'],
          'changed': map['changed'],
        });
        //
        // printLog("map['answer'] ${map['answer']}");
        //
      } else {
        loopData.addAll({'answer': map['answer']});
      }

      finalData.add(loopData);
    }

    Map data = {
      'answers': jsonEncode(finalData),
      'category_id': category.id.toString(),
      'price': finalPrice.toStringAsFixed(2),
      'promo_code_id': promoCode.id.toString(),
      'payment_type': paymentType.text,
      // 'point': '',
      // 'employee_count': '',
    };

    order = await _api.submitOrder(data);
    notifyListeners();

    NavMove.closeDialog(context);

    if (order.id > 0) {
      NavMove.goBack(context);
      if (category.slug.contains("multi-step-order")) {
        NavMove.goBack(context);
      }
      NavMove.goToPage(context, OneOrderPage());
    }
  }

  //

  List<Order> orders = [];
  bool haveMoreOrders = true;
  int _ordersPage = 1;
  String status = 'active';

  Future getOrders() async {
    List<Order> orders = await _api.getOrders(_ordersPage, status);

    this.orders.addAll(orders);
    _ordersPage++;

    if (orders.length < 15) haveMoreOrders = false;

    notifyListeners();

    return;
  }

  changePageStatus(String newStatus) {
    status = newStatus;
    _ordersPage = 1;
    haveMoreOrders = true;
    orders = [];

    getOrders();
  }

  rateOrder(BuildContext context, Map data, int id) async {
    loadingDialog(context);
    // Rate? rate =
    await _api.rateOrder(data);

    // if (rate != null) {
    //   int index = orders.indexWhere((element) => element.id == id);
    //   if (index > -1) orders[index].driver_rate = rate;
    // }

    NavMove.closeDialog(context);

    notifyListeners();
  }

  //
  //
  //
  //
  TextEditingController promoCodeController = TextEditingController();
  TextEditingController paymentType = TextEditingController();

  bool showPromo = false;
  PromoCode promoCode = PromoCode();

  checkPromoCode(BuildContext context) async {
    if (!showPromo) {
      if (promoCodeController.text.length == 0) return;
      FocusScope.of(context).requestFocus(new FocusNode());
      loadingDialog(context);

      showPromo = false;
      promoCode = PromoCode();

      await _api
          .checkPromoCode(promoCodeController.text, category.id)
          .then((value) {
        if (value.id > 0) {
          showPromo = true;
          promoCode = value;
        }
      });

      NavMove.closeDialog(context);
    } else {
      showPromo = false;
      promoCode = PromoCode();
      promoCodeController.text = '';
    }

    calFullPrice();

    notifyListeners();
  }

  Future changeOrderStatus(
      BuildContext context, int newStatus, String reason) async {
    loadingDialog(context);

    Map data = {
      'order_id': this.order.id.toString(),
      'new_status_id': newStatus.toString(),
      'reason': reason.toString(),
    };

    Order? order = await _api.changeOrder(data);
    if (order != null) this.order = order;

    notifyListeners();
    NavMove.closeDialog(context);

    return;
  }

  late Channel privateOrderChannel;

  linkToOrder(BuildContext context) async {
    privateOrderChannel =
        await realTimeProvider.pusher.subscribe('private-order.${order.id}');

    locationProvider.clearMarker();
    locationProvider.setStartEndMarker(
      order.from_address.latitude,
      order.from_address.longitude,
      order.to_address.latitude,
      order.to_address.longitude,
    );
    //
    locationProvider.clearPolylines();
    locationProvider.createPolylines(
      order.from_address.latitude,
      order.from_address.longitude,
      order.to_address.latitude,
      order.to_address.longitude,
    );

    privateOrderChannel.bind('client-driver-location',
        (PusherEvent? event) async {
      if (event?.data != null) {
        Map data = jsonDecode(event!.data ?? '');

        moveMarker(LatLng(data['latitude'], data['longitude']));
      }
    });
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  moveMarker(LatLng latLng) async {
    Uint8List imgurl = (await rootBundle.load('assets/icons/near_driver.png'))
        .buffer
        .asUint8List();

    Uint8List? smallimg = resizeImage(imgurl, 150, 150);

    locationProvider.moveMarkers(Marker(
      markerId: MarkerId('driver-location'),
      position: latLng,
      infoWindow: InfoWindow(title: 'Driver Location'),
      icon: BitmapDescriptor.fromBytes(smallimg!),
    ));

    locationProvider.animateTo(latLng.latitude, latLng.longitude);

    notifyListeners();
  }

  // sendCurrentPositionOnOrder(LatLng latLng) async {
  //   if (!authProvider.isLogIn) return;

  //   if (order.id > 0)
  //     privateOrderChannel.trigger(
  //       'driver-location',
  //       jsonEncode(
  //           {"latitude": latLng.latitude, "longitude": latLng.longitude}),
  //     );
  // }

  Future getNorRatedOrder(BuildContext context) async {
    Order? order = await _api.getNorRatedOrder();

    if (order != null) {
      // printLog('data order ${order.id}');
      var res = await chooseYesNoDialog(
        context,
        S.current.rateTheServiceProvider,
        showNo: false,
        withRate: true,
        withInput: true,
        textInput: S.current.howIsTheServiceProvider,
      );

      if (res != null && res['choose']) {
        Map data = {
          'order_id': order.id.toString(),
          'text': res['input'].toString(),
          'stars_count': res['rate'].toString(),
        };

        rateOrder(context, data, order.id);
      }
    }

    notifyListeners();
  }

//   here to init var
  double timeCost = 0.0;

  double fromlatitude = 0.0;
  double fromlongitude = 0.0;
  double tolatitude = 0.0;
  double tolongitude = 0.0;

  Future<double> getDistance({
    double fromlat = 0.0,
    double fromlong = 0.0,
    double tolat = 0.0,
    double tolong = 0.0,
  }) async {
    if (tolat == 0 || tolong == 0 || fromlat == 0 || fromlong == 0) {
      return 0;
    }

    String url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$fromlat,$fromlong&origins=$tolat,$tolong&key=AIzaSyAobEHss6xoqoB16JBHZlkOkZ6QntH-AUk';
    // String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=31.959603,35.864312&origins=31.956869,35.847903&key=AIzaSyAobEHss6xoqoB16JBHZlkOkZ6QntH-AUk';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);

      if (res['rows'][0]['elements'][0]['status'] == 'ZERO_RESULTS') return 0.0;

      double duration = res['rows'][0]['elements'][0]['duration']['value'] / 60;

      // double resD = double.parse(duration.split(' ')[0]);
      if (duration > 5) {
        duration -= 5;
      } else {
        duration = 0;
      }

      timeCost = duration * 0.05;
      return timeCost;
    }

    return 0.0;
  }

  String _cancelReason = '';
  String get cancelReason => _cancelReason;
  set cancelReason(String value) {
    _cancelReason = value;
    notifyListeners();
  }

  bool _other = false;
  bool get other => _other;
  set other(bool value) {
    _other = value;
    notifyListeners();
  }

  TextEditingController otherReason = TextEditingController();

  //
  double final_price(double price) {
    double the_price = 0.0;
    if (promoCode.id > 0) {
      if (promoCode.type == 'fix')
        the_price = price - promoCode.amount;
      else if (promoCode.type == 'percentage')
        the_price = price - (price * promoCode.amount / 100);
    } else {
      the_price = price;
    }

    return the_price;
  }
}
