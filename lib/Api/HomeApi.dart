import 'package:takeh_customer/Api/Api_util.dart';
import 'package:takeh_customer/Models/ApiData.dart';
import 'package:takeh_customer/Models/Applang.dart';
import 'package:takeh_customer/Models/Appsetting.dart';
import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Models/Country.dart';
import 'package:takeh_customer/Models/DriverLocation.dart';
import 'package:takeh_customer/Models/FirebaseNotification.dart';
import 'package:takeh_customer/Models/Slider.dart' as s;
import 'package:takeh_customer/Models/Slider.dart';
import 'package:takeh_customer/Models/StaticPage.dart';

class HomeApi {
  Future<Map> getAppSetting() async {
    int version = 1;
    Appsetting setting = Appsetting();
    List<Country> countrys = [];
    List<Applang> applangs = [];

    String url = ApiUtil.App_Setting;

    ApiData response = await theGet(url);
    if (response.statusCode == 200 && response.data != null) {
      if (response.data['version'] != null) version = response.data['version'];

      if (response.data['setting'] != null)
        setting = Appsetting.fromAPI(response.data['setting']);

      if (response.data['countrys'] != null)
        countrys = await loopCountrys(response.data['countrys']);

      if (response.data['applangs'] != null)
        applangs = await loopApplangs(response.data['applangs']);
    }

    return {
      'version': version,
      'setting': setting,
      'countrys': countrys,
      'applangs': applangs,
    };
  }

  //
  Future<Map> getHome() async {
    List<Category> categorys = [];
    List<s.Slider> sliders = [];
    // double points = 0.0;

    String url = ApiUtil.App_Home;
    ApiData response = await theGet(url);

    if (response.statusCode == 200 && response.data != null) {
      if (response.data['categorys'] != null)
        categorys = await loopCategorys(response.data['categorys']);

      if (response.data['sliders'] != null)
        sliders = await loopSliders(response.data['sliders']);

      // if (response.data['points'] != null)
      //   points = response.data['points'] + 0.0;
    }

    return {
      'categorys': categorys,
      'sliders': sliders,
      // 'points': points,
    };
  }

  Future<List<FirebaseNotification>> getNotifications(int page) async {
    List<FirebaseNotification> notifications = [];

    String url = ApiUtil.Notifications + '?page=$page';
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      notifications =
          await loopFirebaseNotifications(response.data['notifications']);

    return notifications;
  }

  Future<StaticPage> getStaticPage(String pageLink) async {
    StaticPage page = StaticPage();
    String url = ApiUtil.Static_Page + '?static_page=$pageLink';
    ApiData response = await theGet(url);
    if (response.statusCode == 200)
      page = StaticPage.fromAPI(response.data['static_page']);
    return page;
  }

  Future<List<DriverLocation>> getNearLocation(
      double lat, double long, int catID) async {
    List<DriverLocation> driverlocation = [];

    String url =
        ApiUtil.Location + '?latitude=$lat&longitude=$long&category=$catID';

    ApiData response = await theGet(url);

    if (response.statusCode == 200 && response.data != null) {
      if (response.data['near-drivers-location'] != null)
        driverlocation =
            await loopDriverLocation(response.data['near-drivers-location']);
    }

    return driverlocation;
  }
}
