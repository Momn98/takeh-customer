// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:takeh_customer/Models/ApiData.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';
import 'package:takeh_customer/main.dart';

const String MAIN_API_URL = 'https://app.takeh.online/api/';

Map<String, String> _theHeder = {
  'X-Requested-With': 'XMLHttpRequest',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${SharedManager.shared.token}',
  'application': 'customer',
};

Future<void> _getToken() async {
  SharedPreferences _pre = await SharedPreferences.getInstance();

  String _token = _pre.getString(SharedKeys.token) ?? '';
  if (_token.length > 10) _theHeder.addAll({'Authorization': 'Bearer $_token'});
  //

  _theHeder.addAll({'lang': tabBarProvider.locale.languageCode});
  _theHeder.addAll({'currency': tabBarProvider.currency});
  _theHeder.addAll({'country': tabBarProvider.country});

  // printLog("_theHeder -> lang ${_theHeder['lang']}");
  // printLog("_theHeder -> currency ${_theHeder['currency']}");
  // printLog("_theHeder -> country ${_theHeder['country']}");
}

class ApiUtil {
  //
  static const String _AUTH = 'auth/user/';
  //
  static const String Check_Number = _AUTH + 'check/phone';
  //
  static const String Check_Email = _AUTH + 'check/email';
  //
  static const String SIGN_UP = _AUTH + 'sign-up';
  //
  static const String AUTH_INFO = _AUTH + 'info';
  //
  static const String LOG_IN = _AUTH + 'log-in';
  //
  static const String SEND_OTP = _AUTH + 'send-otp';
  //
  static const String CHECK_OTP = _AUTH + 'check-otp';
  //
  static const String USER = _AUTH + 'user';
  //
  static const String LOG_OUT = _AUTH + 'log-out';
  //
  static const String UPDATE_USER_INFO = _AUTH + 'update-info';
  //
  static const String CHANGE_NUMBER_1 = _AUTH + 'change-number-1';
  //
  static const String CHANGE_NUMBER_2 = _AUTH + 'change-number-2';
  //
  static const String Delete_Account = _AUTH + 'delete/account';
  //
  //
  //
  //
  //
  static const String _USER = 'user/';
  //
  static const String App_Setting = _USER + 'app-setting';
  //
  static const String App_Home = _USER + 'app-home';
  //
  // static const String Banner = _USER + 'banner';
  //
  static const String Notifications = _USER + 'notifications';
  //
  static const String Static_Page = _USER + 'static-page';
  //
  static const String Address = _USER + 'address';
  //
  static const String Submit_Order = _USER + 'order';
  //
  static const String Orders = _USER + 'orders';
  //
  static const String Not_Rated_Order = _USER + 'not-rated-order';
  //
  static const String Change_Order = _USER + 'change-order';
  //
  static const String Rate_Order = _USER + 'rate-order';
  //
  static const String PromoCodeCheck = _USER + 'promo/code/check';
  //
  static const String Location = _USER + 'driver-location';
  //
}

// the get for data
Future<ApiData> theGet(String _endUrl) async {
  await _getToken();

  http.Response response = await http.get(
    Uri.parse(MAIN_API_URL + _endUrl),
    headers: _theHeder,
  );

  // printLog('theGet -> _endUrl $_endUrl');
  // printLog('theGet -> response.statusCode ${response.statusCode}');
  // printLog('theGet -> response.body ${response.body}');

  return ApiData.fromAPI(response);
}

// the post for data
Future<ApiData> theSend(String _endUrl, Map jsonData) async {
  await _getToken();
  // make POST request

  http.Response response = await http.post(
    Uri.parse(MAIN_API_URL + _endUrl),
    headers: _theHeder,
    body: jsonData,
  );

  // printLog('theSend -> jsonData $jsonData');
  // printLog('theSend -> _endUrl $_endUrl');
  // printLog('theSend -> response.statusCode ${response.statusCode}');
  // printLog('theSend -> response.body ${response.body}');

  return ApiData.fromAPI(response);
}

// the put for data
Future<ApiData> thePut(String _endUrl, Map jsonData) async {
  await _getToken();

  http.Response response = await http.put(
    Uri.parse(MAIN_API_URL + _endUrl),
    headers: _theHeder,
    body: jsonData,
  );

  // printLog('thePut -> _endUrl $_endUrl');
  // printLog('thePut -> response.statusCode ${response.statusCode}');
  // printLog('thePut -> response.body ${response.body}');

  return ApiData.fromAPI(response);
}

// the delete for data
Future<ApiData> theDelete(String _endUrl) async {
  await _getToken();

  http.Response response = await http.delete(
    Uri.parse(MAIN_API_URL + _endUrl),
    headers: _theHeder,
  );

  // printLog('theDelete -> _endUrl $_endUrl');
  // printLog('theDelete -> response.statusCode ${response.statusCode}');
  // printLog('theDelete -> response.body ${response.body}');

  return ApiData.fromAPI(response);
}
