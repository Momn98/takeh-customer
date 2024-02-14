// AIzaSyAobEHss6xoqoB16JBHZlkOkZ6QntH-AUk -> good
// AIzaSyBRI1viD6gRSQ7-T_YqGpy8-wERmYhkn-k -> not-work

import 'package:takeh_customer/Pages/Stander-Pages/SplashScreen.dart';
import 'package:takeh_customer/Provider/UserRealTimeProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:takeh_customer/Provider/RealTimeProvider.dart';
import 'package:takeh_customer/Provider/AddressProvider.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Provider/QrCodeProvider.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Provider/HomeProvider.dart';
import 'package:takeh_customer/Provider/SignProvider.dart';
import 'package:takeh_customer/Shared/Providers.dart';
import 'package:takeh_customer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/Shared/FCM.dart';
import 'package:wakelock/wakelock.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Flutter version 3.7.11 on channel stable
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // if (message.data['page'].contains('order')) {
  if (message.notification != null) {
    NotificationService.showNotification(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString(),
    );
  }
  // }

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.initializeNotification();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: providers,
      child: TheMainApp(),
    );
  }
}

late TabBarProvider tabBarProvider;
late AuthProvider authProvider;
late SignProvider signProvider;
late HomeProvider homeProvider;
late QrCodeProvider qrCodeProvider;
late LocationProvider locationProvider;
late OrderProvider orderProvider;
late AddressProvider addressProvider;
late RealTimeProvider realTimeProvider;
late UserRealTimeProvider userRealTimeProvider;

class TheMainApp extends StatefulWidget {
  @override
  State<TheMainApp> createState() => _TheMainAppState();
}

class _TheMainAppState extends State<TheMainApp> {
  @override
  void initState() {
    Wakelock.enable();
    tabBarProvider = Provider.of<TabBarProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    signProvider = Provider.of<SignProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    qrCodeProvider = Provider.of<QrCodeProvider>(context, listen: false);
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    addressProvider = Provider.of<AddressProvider>(context, listen: false);
    realTimeProvider = Provider.of<RealTimeProvider>(context, listen: false);
    userRealTimeProvider =
        Provider.of<UserRealTimeProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarProvider>(
      builder: (_, v, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: v.locale,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: S.current.appName,
          home: SplashScreen(),
        );
      },
    );
  }
}
