import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Models/User.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class UserRealTimeProvider extends ChangeNotifier {
  late Channel privateUserChannel;
  late User user;

  linkToUser(BuildContext context) async {
    await realTimeProvider.connect();
    user = authProvider.user;

    privateUserChannel =
        await realTimeProvider.pusher.subscribe('private-user.${user.id}');

    privateUserChannel.bind('update-order', (PusherEvent? event) async {
      if (event?.data != null) {
        Map data = jsonDecode(event!.data ?? '');

        Order order = Order.fromAPI(data['order']);

        if (order.id == orderProvider.order.id)
          orderProvider.updateOrder(order);

        orderProvider.updateOrderInOrders(order);

        notifyListeners();

        if (data['action'] == 'update-user') {
          if (order.status.id == 7) {
            var resRate = await chooseYesNoDialog(
              context,
              S.current.rateTheServiceProvider,
              withRate: true,
              showNo: false,
              withInput: true,
              textInput: S.current.howIsTheServiceProvider,
            );

            if (resRate == null) return;
            Map apiData = {
              'order_id': order.id.toString(),
            };

            try {
              if (resRate['input'] != null)
                apiData.addAll({
                  'text': resRate['input'].toString(),
                });
            } catch (e) {}
            try {
              apiData.addAll({
                'stars_count': resRate['rate'].toString(),
              });
            } catch (e) {}

            await orderProvider.rateOrder(context, apiData, order.id);
          }
        }
      }
    });

    privateUserChannel.bind('client-update-order', (PusherEvent? event) {
      if (event?.data != null) {
        Map data = jsonDecode(event!.data ?? '');
        // printLog("client-update-order $data");

        if (data['order'] != null) {
          Order order = Order.fromAPI(data['order']);

          if (order.id == orderProvider.order.id)
            orderProvider.updateOrder(order);

          orderProvider.updateOrderInOrders(order);
        }

        notifyListeners();
      }
    });
  }

  // Uint8List? resizeImage(Uint8List data, width, height) {
  //   Uint8List? resizedData = data;
  //   IMG.Image? img = IMG.decodeImage(data);
  //   IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
  //   resizedData = Uint8List.fromList(IMG.encodePng(resized));
  //   return resizedData;
  // }

  // moveMarker(LatLng latLng) async {
  //   Uint8List imgurl =
  //       (await rootBundle.load('assets/icons/taxi.png')).buffer.asUint8List();

  //   Uint8List? smallimg = resizeImage(imgurl, 150, 150);

  //   locationProvider.moveMarkers(Marker(
  //     markerId: MarkerId('driver-location'),
  //     position: latLng,
  //     infoWindow: InfoWindow(title: 'Driver Location'),
  //     icon: BitmapDescriptor.fromBytes(smallimg!),
  //   ));

  //   locationProvider.animateTo(latLng.latitude, latLng.longitude);

  //   notifyListeners();
  // }
}
