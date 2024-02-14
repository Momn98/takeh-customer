import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeh_customer/Models/Applang.dart';
import 'package:takeh_customer/Pages/Auth/AuthView.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class SelectLangCountryFirstTime extends StatefulWidget {
  const SelectLangCountryFirstTime({super.key});

  @override
  State<SelectLangCountryFirstTime> createState() =>
      _SelectLangCountryFirstTimeState();
}

class _SelectLangCountryFirstTimeState
    extends State<SelectLangCountryFirstTime> {
  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      body: Consumer<TabBarProvider>(
        builder: (_, v, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: LogoImage.logoNoBack,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              Container(width: double.infinity),
              globalText(
                S.current.welcome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              globalText(
                S.current.aSmartUserHasJustDownloadedNourAppExcellent,
                textAlign: TextAlign.start,
              ),
              Spacer(),
              globalText(
                S.current.selectlanguage,
              ),
              setHeightSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                  items: v.applangs
                      .map((e) => DropdownMenuItem<String>(
                          value: e.code, child: Text(e.name)))
                      .toList(),
                  isExpanded: true,
                  value: v.locale.languageCode,
                  underline: Container(),
                  onChanged: (value) async {
                    Applang applang =
                        v.applangs.firstWhere((el) => el.code == value);
                    await v.changeLanguage(applang);

                    tabBarProvider.start();
                  },
                ),
              ),
              setHeightSpace(20),
              globalText(S.current.selectYourCountry),
              setHeightSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                  items: v.isRTL ? v.countrys_ar : v.countrys_en,
                  isExpanded: true,
                  value: v.country,
                  underline: Container(),
                  onChanged: (value) {
                    v.changeCountry(value);
                  },
                ),
              ),
              setHeightSpace(10),
              Container(
                width: double.infinity,
                child: globalButton(
                  S.current.letsGetStarted,
                  () {
                    authProvider.setFirstTime();
                    NavMove.goToPage(context, AuthView());
                  },
                  backColor: AppColor.orange,
                  borderColor: AppColor.orange,
                  textColor: Colors.white,
                  fontWeight: FontWeight.normal,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Powerd by codexal'),
            Image(image: LogoImage.codexal, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
