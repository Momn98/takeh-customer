import 'package:takeh_customer/Pages/Auth/AuthView.dart';
import 'package:page_transition/page_transition.dart';
import 'package:takeh_customer/Pages/Auth/OtpPage.dart';
import 'package:takeh_customer/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavMoveNoReturn {
  static goMain(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        duration: Duration(milliseconds: 0),
        type: PageTransitionType.fade,
        child: MyApp(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static goToPage(BuildContext context, Widget page, {bool mustLogin = false}) {
    // if (mustLogin && !authProvider.isLogIn) return goAuthView(context);
    return Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        duration: Duration(milliseconds: 0),
        type: PageTransitionType.fade,
        child: page,
      ),
      (Route<dynamic> route) => false,
    );
  }
}

class NavMove {
  // static bool _isDialogShowing(BuildContext context) =>
  //     ModalRoute.of(context)?.isCurrent != true;

  static closeDialog(BuildContext context) {
    // if (_isDialogShowing(context))
    if (Navigator.canPop(context))
      return Navigator.of(context, rootNavigator: true).pop();
  }

  static void closeKeyBoard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static goBack(BuildContext context, {Map? data}) {
    if (Navigator.canPop(context)) return Navigator.pop(context, data);
  }

  static _goAuthView(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageTransition(
        duration: Duration(milliseconds: 0),
        type: PageTransitionType.fade,
        child: AuthView(),
      ),
    );
  }

  static goToPage(BuildContext context, Widget page,
      {bool mustLogin = false}) async {
    if (mustLogin && !authProvider.isLogIn) return _goAuthView(context);

    return await Navigator.of(context, rootNavigator: true).push(
      PageTransition(
        duration: Duration(milliseconds: 0),
        type: PageTransitionType.fade,
        child: page,
      ),
    );
  }

  static goOTPPage(BuildContext context, Map data, bool haveAccount) {
    return Navigator.of(context, rootNavigator: true).push(
      PageTransition(
        duration: Duration(milliseconds: 0),
        type: PageTransitionType.fade,
        child: OtpPageView(data: data, haveAccount: haveAccount),
      ),
    );
  }
}
