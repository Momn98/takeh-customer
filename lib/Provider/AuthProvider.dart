import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeh_customer/Api/UserApi.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Global/loadingDialog.dart';
import 'package:takeh_customer/Models/User.dart';
import 'package:takeh_customer/Pages/Auth/AuthView.dart';
import 'package:takeh_customer/Pages/Auth/SelectLangCountryFirstTime.dart';
import 'package:takeh_customer/Pages/Auth/SignUpPage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/BlockedPage.dart';
import 'package:takeh_customer/Pages/TabBar/HomeTabBarView.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class AuthProvider extends ChangeNotifier {
  UserApi _api = UserApi();
  User user = User();

  bool isLogIn = false;
  bool isFirstTime = false;

  set userIn(bool val) {
    this.isLogIn = val;
    SharedPreferences.getInstance().then((value) {
      value.setBool(SharedKeys.isLogedIn, this.isLogIn);
    });
  }

  Future<bool> get isUserLogIn async {
    await SharedPreferences.getInstance().then((value) {
      this.isLogIn = value.getBool(SharedKeys.isLogedIn) ?? false;
    });
    return this.isLogIn;
  }

  setFirstTime() {
    SharedPreferences.getInstance().then((value) {
      value.setBool(SharedKeys.isFirstTime, false);
    });
    this.isFirstTime = false;
  }

  checkIfUserLogin(BuildContext context) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    isLogIn = pre.getBool(SharedKeys.isLogedIn) ?? false;
    isFirstTime = pre.getBool(SharedKeys.isFirstTime) ?? true;

    if (isFirstTime)
      return NavMoveNoReturn.goToPage(context, SelectLangCountryFirstTime());

    if (!isLogIn) return NavMoveNoReturn.goToPage(context, AuthView());

    getUser(context);
  }

  Future chickThe(
    BuildContext context,
    Map data, {
    bool logInByNumber = true,
    bool isByLogin = true,
  }) async {
    loadingDialog(context);
    if (logInByNumber) {
      _api.checkPhone(data, show: isByLogin).then((value) async {
        NavMove.closeDialog(context);
        // printLog("value $value");
        // printLog("isLogIn $isByLogin");
        // printLog("signProvider.isLogin ${signProvider.isLogin}");

        // if (isByLogin && value) return NavMove.goOTPPage(context, data, true);

        if (isByLogin && value['can_login']) {
          return NavMove.goOTPPage(context, data, true);
        }

        if (isByLogin && value['can_sign_up']) {
          var res = await chooseYesNoDialog(
            context,
            S.current.userNotFound,
            extraText: S.current.phoneNumberNotRejecteredWithAnyUser,
          );

          if (res != null && res['choose']) {
            signProvider.isLogin = false;

            return NavMoveNoReturn.goToPage(context, SignUpPage());
          }
          // } else {
          //
        }

        // return NavMove.goOTPPage(context, data, value);

        notifyListeners();
        return;
      });
    } else {
      // _api.checkEmail(data).then((value) async {
      //   NavMove.closeDialog(context);
      //   if (isLogin || value) {
      //     _logIn(context, data);
      //   } else {
      //     _signUp(context, data);
      //   }
      // });
    }
  }

  getUser(BuildContext context, {bool moveAfterDone = true}) {
    _api.getUser().then((value) async {
      if (value['good']) {
        this.user = value['user'];

        // if (this.user.status == 'pending')
        //   return NavMoveNoReturn.goToPage(context, PendingPage());
        // else
        if (this.user.status == 'blocked')
          return NavMoveNoReturn.goToPage(context, BlockedPage());

        notifyListeners();
        if (moveAfterDone)
          return NavMoveNoReturn.goToPage(context, HomeTabBarView());
      } else {
        if (moveAfterDone) return NavMoveNoReturn.goToPage(context, AuthView());
      }
    });
  }

  logIn(BuildContext context, Map data, bool showMessage) async {
    loadingDialog(context);
    _api.logIn(data).then((value) {
      NavMove.closeDialog(context);
      if (value != null && value != false) {
        this.isLogIn = true;
        this.user = value['user'];

        // if (this.user.status == 'pending')
        //   return NavMoveNoReturn.goToPage(context, PendingPage());
        // else
        if (this.user.status == 'blocked')
          return NavMoveNoReturn.goToPage(context, BlockedPage());

        // walletProvider.wallet = this.user.wallet;
        notifyListeners();
        NavMoveNoReturn.goToPage(context, HomeTabBarView());
      }
    });
  }

  signUp(BuildContext context, Map data, bool showMessage) async {
    loadingDialog(context);
    // bool isExest = await _api.checkPhone(data, show: showMessage);

    // if (isExest) return screenMessage(S.current.alredyHaveAccount);
    _api.signUp(data).then((value) {
      NavMove.closeDialog(context);
      if (value != null && value != false) {
        if (value['good']) {
          this.user = value['user'];
          // walletProvider.wallet = this.user.wallet;
          isLogIn = true;
          NavMoveNoReturn.goToPage(context, HomeTabBarView());
        }
      }
    });
  }

  updateUserApi(BuildContext context, Map data) async {
    loadingDialog(context);
    this.user = await _api.updateUserInfo(data);
    screenMessage(S.current.updated);
    NavMove.closeDialog(context);
    notifyListeners();
    // if (this.user.status == 'pending')
    //   return NavMoveNoReturn.goToPage(context, PendingPage());
    // else
    if (this.user.status == 'blocked')
      return NavMoveNoReturn.goToPage(context, BlockedPage());
  }

  logOut(BuildContext context) async {
    loadingDialog(context);
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    await _api.logout();

    _sharedPreferences.setBool(SharedKeys.isLogedIn, false);
    _sharedPreferences.setBool(SharedKeys.isFirstTime, true);
    _sharedPreferences.setString(SharedKeys.token, '');

    isLogIn = false;
    SharedManager.shared.currentIndex = 0;
    user = User();

    NavMove.closeDialog(context);
    NavMoveNoReturn.goMain(context);
  }

  bool codeSend = false;
  Future<bool> sendOtpCode(BuildContext context, String phone, String signature,
      {bool withLoading = true}) async {
    codeSend = false;
    if (withLoading) loadingDialog(context);

    bool res = await _api.sendOtpCode(phone, signature);

    if (withLoading) NavMove.closeDialog(context);
    // if (withLoading)
    notifyListeners();

    if (res) restartTimer();

    codeSend = res;

    return res;
  }

  Future<bool> checkOtpCode(
      BuildContext context, String phone, String code) async {
    loadingDialog(context);

    bool res = await _api.checkOtpCode(phone, code);

    NavMove.closeDialog(context);

    return res;
  }

  deleteAccount(BuildContext context) async {
    loadingDialog(context);

    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    bool isDelete = await _api.deleteAccount();

    if (isDelete) {
      _sharedPreferences.setBool(SharedKeys.isLogedIn, false);
      _sharedPreferences.setString(SharedKeys.token, '');
      _sharedPreferences.setBool(SharedKeys.isFirstTime, true);

      isLogIn = false;
      SharedManager.shared.currentIndex = 0;
      user = User();
      NavMoveNoReturn.goMain(context);
    }
  }

  int timeDown = 30;
  bool stop = false;

  countDown() {
    if (timeDown == 0) return;
    if (stop) return;

    Timer(Duration(seconds: 1), () {
      timeDown--;
      notifyListeners();
      return countDown();
    });
  }

  restartTimer() {
    timeDown = 30;

    countDown();
  }

  getWallet() {
    _api.getUser().then((value) async {
      if (value['good']) {
        this.user.wallet = value['user'].wallet;

        notifyListeners();
      }
    });
  }
}
