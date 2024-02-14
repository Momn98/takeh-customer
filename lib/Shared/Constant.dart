import 'package:intl/src/intl/text_direction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

String googleMapKey = 'AIzaSyAobEHss6xoqoB16JBHZlkOkZ6QntH-AUk';
const int appVersion = 11;

class AppColor {
  static Color orange = hexToColor('#D18700');
  static Color secondary = hexToColor('#3A6547');
}

class LogoImage {
  static const String _asset = 'assets/logo/';
  static const AssetImage logo = AssetImage(_asset + 'logo.png');
  // static const AssetImage logo5o5ah = AssetImage(_asset + '5o5ah.png');
  static const AssetImage codexal =
      AssetImage(_asset + 'codexal-logo-no-back.png');
  static const AssetImage logoNoBack = AssetImage(_asset + 'logo-no-back.png');
  // static const AssetImage splash = AssetImage(_asset + 'logo.png');
}

class IconSvg {
  static const String _asset = 'assets/icons/';

  static const String home = _asset + 'home.png';
  static const String support = _asset + 'support.png';
  static const String orders = _asset + 'orders.png';
  static const String profile = _asset + 'profile.png';
  static const String scan = _asset + 'scan.png';
  static const AssetImage male = AssetImage(_asset + 'male.png');
  static const AssetImage female = AssetImage(_asset + 'female.png');

  static const String notification = _asset + 'notification.png';

  static const String add_outline = _asset + 'add-outline.svg';
  static const String delete_outline = _asset + 'delete-outline.svg';

  static const AssetImage location = AssetImage(_asset + 'location.png');
  // static SvgPicture finding = SvgPicture.asset(_asset + 'finding.svg');
  static SvgPicture address_from =
      SvgPicture.asset(_asset + 'address_from.svg');
  static SvgPicture address_to = SvgPicture.asset(_asset + 'address_to.svg');
}

class GlobalImage {
  static const String _asset = 'assets/global/';
  static const AssetImage cash = AssetImage(_asset + 'cash.png');
  static const AssetImage clock = AssetImage(_asset + 'clock.png');

  static SvgPicture unlock = SvgPicture.asset(_asset + 'unlock.svg');
  static const AssetImage delete = AssetImage(_asset + 'delete.png');

  // static const AssetImage bg = AssetImage(_asset + 'home_background.png');
  static const String bg = _asset + 'home_background.jpeg';

  static String finding_gif = _asset + 'finding.gif';
  static const String splash_screen = _asset + 'splash-screen.gif';
  static const String splash_screen2 = _asset + 'splash_screen2.jpeg';
  static const String splash_screen3 = _asset + 'splash_screen3.jpeg';
}

// class LoginImage {
//   static const String _asset = 'assets/login/';
//   static const AssetImage pin = AssetImage(_asset + 'pin.png');
//   static const AssetImage apple = AssetImage(_asset + 'apple.png');
//   static const AssetImage facebook = AssetImage(_asset + 'facebook.png');
//   static const AssetImage google = AssetImage(_asset + 'google.png');
//   static const AssetImage email = AssetImage(_asset + 'email.png');
//   static const AssetImage mail = AssetImage(_asset + 'mail.png');
// }

class SocialImage {
  static const String _asset = 'assets/social/';

  static const AssetImage phone = AssetImage(_asset + 'phone-call.png');
  static const AssetImage facebook = AssetImage(_asset + 'facebook.png');
  static const AssetImage instagram = AssetImage(_asset + 'instagram.png');
  static const AssetImage messenger = AssetImage(_asset + 'messenger.png');
  static const AssetImage snapchat = AssetImage(_asset + 'snapchat.png');
  static const AssetImage tiktok = AssetImage(_asset + 'tiktok.png');
  static const AssetImage whatsapp = AssetImage(_asset + 'whatsapp.png');
}

setHeightSpace(double height) => SizedBox(height: height);

setWithSpace(double width) => SizedBox(width: width);

// // #duration
// const kDuration = Duration(milliseconds: 300);

// class Familys {
//   static String rubik = 'rubik';
// }

const printLogTag = '[Takeh-App] -> ';
const printLogEnable = true;

printLog(dynamic data) {
  if (printLogEnable) {
    // if (kDebugMode)
    log('$printLogTag${data.toString()}');
  }
}

Color hexToColor(String code) =>
    Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);

String colorToHex(Color color) =>
    '#${color.value.toRadixString(16).padLeft(6, '').substring(2, 8).toUpperCase()}';

bool isRTL(BuildContext context) => Directionality.of(context)
    .toString()
    .contains(TextDirection.RTL.value.toLowerCase());

class Familys {
  static String futur = 'futur';
  static String Futura_Bold_font = 'Futura-Bold-font';
  static String Futura_Bold_Italic_font = 'Futura-Bold-Italic-font';
  static String Futura_Book_font = 'Futura-Book-font';
  static String Futura_Book_Italic_font = 'Futura-Book-Italic-font';
  static String Futura_Extra_Black_font = 'Futura-Extra-Black-font';
  static String Futura_Heavy_font = 'Futura-Heavy-font';
  static String Futura_Heavy_Italic_font = 'Futura-Heavy-Italic-font';
  static String futura_light_bt = 'futura-light-bt';
  static String Futura_Light_font = 'Futura-Light-font';
  static String Futura_Light_Italic_font = 'Futura-Light-Italic-font';
  static String futura_medium_bt = 'futura-medium-bt';
  static String futura_medium_condensed_bt = 'futura-medium-condensed-bt';
  static String Futura_Medium_Italic_font = 'Futura-Medium-Italic-font';
  static String Futura_XBlk_BT = 'Futura-XBlk-BT';
  static String Futura_CondensedLight = 'Futura-CondensedLight';
  static String tt0205m = 'tt0205m';
  static String unicode_futurab = 'unicode.futurab';
  static String unicode_futurabb = 'unicode.futurabb';
  static String Tajawal_Black = 'Tajawal-Black';
  static String Tajawal_Bold = 'Tajawal-Bold';
  static String Tajawal_ExtraBold = 'Tajawal-ExtraBold';
  static String Tajawal_ExtraLight = 'Tajawal-ExtraLight';
  static String Tajawal_Light = 'Tajawal-Light';
  static String Tajawal_Medium = 'Tajawal-Medium';
  static String Tajawal_Regular = 'Tajawal-Regular';
}
