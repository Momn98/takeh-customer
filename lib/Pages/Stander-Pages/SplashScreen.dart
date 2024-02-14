import 'package:flutter/material.dart';
import 'dart:async';

import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startApp();
    super.initState();
  }

  startApp() {
    Timer(Duration(seconds: 3), () {
      authProvider.checkIfUserLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                GlobalImage.splash_screen3,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                GlobalImage.splash_screen,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Powerd by codexal',
              style: TextStyle(color: Colors.black),
            ),
            setWithSpace(10),
            Image(image: LogoImage.codexal, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
