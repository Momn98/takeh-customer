import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:takeh_customer/Pages/Account/AccountPage.dart';
import 'package:takeh_customer/Pages/Home/HomePage.dart';
import 'package:takeh_customer/Pages/Orders/OrderListPage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/NotificationListPage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/UpdateAppPage.dart';
import 'package:takeh_customer/Pages/TabBar/supportPopUp.dart';
import 'package:takeh_customer/Shared/FCM.dart';
// import 'package:takeh_customer/Shared/FCM.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeTabBarView extends StatefulWidget {
  const HomeTabBarView({super.key});

  @override
  State<HomeTabBarView> createState() => _HomeTabBarViewState();
}

class _HomeTabBarViewState extends State<HomeTabBarView> {
  List<Widget> pages = [
    HomePage(),
    OrderListPage(),
    // ScanQrPage(),
    Container(),
    NotificationListPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    homeProvider.start();

    realTimeProvider.connect();
    userRealTimeProvider.linkToUser(context);

    Future.delayed(Duration(seconds: 1), () {
      Fcm.initConfigure(context);
    });

    Timer(Duration(seconds: 1), () {
      if (tabBarProvider.setting.app_version > appVersion)
        NavMoveNoReturn.goToPage(context, UpdateAppPage());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: DoubleBackToCloseApp(
        child: pages[SharedManager.shared.currentIndex],
        snackBar: SnackBar(
          backgroundColor: Colors.black,
          content: globalText(
            S.current.tapBackAgain,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: SharedManager.shared.currentIndex,
        onTap: (int id) {
          if (!mounted) return;

          if (id == 2) return supportPopUp(context);

          // if (id == 3 || id == 4) if (!authProvider.isLogIn)
          //   return NavMove.goToPage(context, AuthView());
          setState(() => SharedManager.shared.currentIndex = id);
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: AppColor.orange,
        // unselectedFontSize: 12,
        // selectedFontSize: 12,
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: tabBarProvider.locale.languageCode == 'ar'
              ? Familys.Tajawal_Regular
              : Familys.futura_medium_bt,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: tabBarProvider.locale.languageCode == 'ar'
              ? Familys.Tajawal_Regular
              : Familys.futura_medium_bt,
        ),
        items: [
          navItem(IconSvg.home, S.current.home),
          navItem(IconSvg.orders, S.current.orders),
          // navItem(IconSvg.scan, S.current.scan),
          navItem(IconSvg.support, S.current.support),
          navItem(IconSvg.notification, S.current.notifications),
          navItem(IconSvg.profile, S.current.profile),
        ],
      ),
    );
  }

  //
  BottomNavigationBarItem navItem(String icon, String? label) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, height: 20),
      activeIcon: Image.asset(icon, height: 20, color: AppColor.orange),
      label: label,
    );
  }
}
