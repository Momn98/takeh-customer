import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';
import 'package:takeh_customer/Models/ApiData.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Api/Api_util.dart';
import 'package:takeh_customer/Models/User.dart';
import 'package:takeh_customer/main.dart';

class UserApi {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late String _token;
  // ignore: unused_field
  late SharedPreferences _sharedPreferences;

  Future getUser() async {
    String url = ApiUtil.USER;
    User user = User();

    await _firebaseMessaging.getToken().then((value) => _token = value!);

    ApiData response = await theSend(url, {'device_token': _token});

    if (response.statusCode == 200) {
      user = User.fromAPI(response.data['user']);
      authProvider.user = user;
      // walletProvider.wallet = user.wallet;
      return {'user': user, 'good': true};
    }
    return {'user': user, 'good': false};
  }

  Future<Map> checkPhone(Map data,
      {bool show = true, bool isLogin = true}) async {
    String url = ApiUtil.Check_Number;
    ApiData response = await theSend(url, {'phone': data['phone']});

    if (show && response.showMessage) screenMessage(response.message);
    return {
      'can_login': response.data['can_login'],
      'can_sign_up': response.data['can_sign_up'],
    };
  }

  Future<bool> sendOtpCode(String phone, String signature) async {
    String url = ApiUtil.SEND_OTP;

    ApiData response = await theSend(url, {
      'phone': phone,
      // 'type': '',
      'applecation': 'customer',
      'signature': signature,
    });

    // printLog('checkPhone response.statusCode ${response.statusCode}');
    // printLog('checkPhone response.body ${response.data}');

    screenMessage(response.message);

    return response.data['otp_send'] ?? false;
  }

  Future<bool> checkOtpCode(String phone, String code) async {
    String url = ApiUtil.CHECK_OTP;

    ApiData response = await theSend(url, {
      'phone': phone,
      // 'type': '',
      'otp_code': code,
      'applecation': 'customer',
    });

    // printLog('checkPhone response.statusCode ${response.statusCode}');
    // printLog('checkPhone response.body ${response.data}');

    screenMessage(response.message);

    return response.data['valed_otp'];
  }

  Future logIn(Map userData) async {
    String url = ApiUtil.LOG_IN;

    await _firebaseMessaging.getToken().then((value) => _token = value!);
    userData['device_token'] = _token;

    ApiData response = await theSend(url, userData);

    if (response.statusCode == 200) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool(SharedKeys.isLogedIn, true);
      _sharedPreferences.setString(
          SharedKeys.token, response.data['access_token']);
      User user = User.fromAPI(response.data['user']);
      authProvider.user = user;
      authProvider.isLogIn = true;
      // walletProvider.wallet = user.wallet;
      return {'user': user, 'good': true};
    }
    // if (response.showMessage)
    screenMessage(response.message);
    return false;
  }

  Future signUp(Map userData) async {
    String url = ApiUtil.SIGN_UP;

    await _firebaseMessaging.getToken().then((value) => _token = value!);
    userData['device_token'] = _token;

    ApiData response = await theSend(url, userData);

    if (response.statusCode == 201) {
      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool(SharedKeys.isLogedIn, true);

      _sharedPreferences.setString(
          SharedKeys.token, response.data['access_token']);
      User user = User.fromAPI(response.data['user']);
      authProvider.isLogIn = true;
      authProvider.user = user;
      // walletProvider.wallet = user.wallet;
      return {'user': user, 'good': true};
    }

    if (response.showMessage) screenMessage(response.message);
    return false;
  }

  Future<User> updateUserInfo(Map data) async {
    String url = ApiUtil.UPDATE_USER_INFO;
    ApiData response = await theSend(url, data);

    User user = authProvider.user;
    if (response.statusCode == 202) {
      user = User.fromAPI(response.data['user']);
      authProvider.user = user;
      // walletProvider.wallet = user.wallet;
      return user;
    }
    return user;
  }

  Future logout() async {
    String url = ApiUtil.LOG_OUT;
    await theGet(url);
    authProvider.user = User();
    authProvider.isLogIn = false;

    return true;
  }

  Future<bool> deleteAccount() async {
    String url = ApiUtil.Delete_Account;

    ApiData response = await theGet(url);

    if (response.statusCode == 209)
      return response.data['user_deleted'] == true ? true : false;

    return false;
  }
}
