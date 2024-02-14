import 'package:takeh_customer/Models/FirebaseNotification.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Models/DriverLocation.dart';
import 'package:takeh_customer/Models/Slider.dart' as s;
import 'package:takeh_customer/Models/StaticPage.dart';
import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Api/HomeApi.dart';
import 'package:takeh_customer/main.dart';
import 'package:image/image.dart' as IMG;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeProvider extends ChangeNotifier {
  HomeApi _api = HomeApi();

  start() async {
    await this.getHomeData();
    return;
  }

  List<s.Slider> _sliders = [];
  List<s.Slider> get sliders => _sliders;
  set sliders(List<s.Slider> sliders) => _sliders = sliders;

  List<Category> _categorys = [];
  List<Category> get categorys => _categorys;
  set categorys(List<Category> categorys) => _categorys = categorys;

  // double points = 0.0;

  getHomeData() async {
    Map homeData = await this._api.getHome();

    this.categorys = homeData['categorys'];
    this.sliders = homeData['sliders'];

    // this.points = homeData['points'];
    notifyListeners();
  }

  int notificationsCount = 0;
  List<FirebaseNotification> _notifications = [];
  List<FirebaseNotification> get notifications => _notifications;
  set notifications(List<FirebaseNotification> notifications) {
    _notifications = notifications;
  }

  int _notifiPage = 1;
  bool haveMoreNotifications = true;

  clear() {
    _notifications = [];
    _notifiPage = 1;
    haveMoreNotifications = true;
  }

  getNotifications() async {
    List<FirebaseNotification> notifications =
        await _api.getNotifications(_notifiPage);

    _notifications.addAll(notifications);
    _notifiPage++;

    if (notifications.length < 15) haveMoreNotifications = false;

    notifyListeners();
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  getNearLocations(double fromLat, double fromLong, int catID) async {
    List<DriverLocation> getNears =
        await this._api.getNearLocation(fromLat, fromLong, catID);

    Uint8List imgurl = (await rootBundle.load('assets/icons/near_driver.png'))
        .buffer
        .asUint8List();
    Uint8List? smallimg = resizeImage(imgurl, 150, 150);

    locationProvider.markers = {};

    for (DriverLocation loc in getNears) {
      locationProvider.moveMarkers(
        Marker(
          markerId: MarkerId('driver-${loc.id}'),
          position: LatLng(loc.lat, loc.long),
          icon: BitmapDescriptor.fromBytes(smallimg!),
        ),
      );
    }

    notifyListeners();
  }

  StaticPage staticPage = StaticPage();
  bool haveStaticPage = false;
  getPoliciesApi(String page) async {
    haveStaticPage = false;
    staticPage = StaticPage();
    await _api.getStaticPage(page).then((value) {
      staticPage = value;
      haveStaticPage = true;
    });

    notifyListeners();
  }
}
