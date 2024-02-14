// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Global/SocialMedia.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(text: S.current.contactUs),
      body: Consumer<TabBarProvider>(
        builder: (_, v, __) {
          return Column(
            children: [
              setHeightSpace(40),
              if (v.setting.contact_phone.length > 0) ...[
                setHeightSpace(10),
                globalText(
                  S.current.mobileNumber,
                  style: TextStyle(color: Colors.grey),
                ),
                setHeightSpace(10),
                InkWell(
                  onTap: () => launch('tel:${v.setting.contact_phone}'),
                  child: globalText(
                    v.setting.contact_phone,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
              if (v.setting.contact_email.length > 0) ...[
                setHeightSpace(10),
                globalText(
                  S.current.email,
                  style: TextStyle(color: Colors.grey),
                ),
                setHeightSpace(10),
                globalText(
                  v.setting.contact_email,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 23,
                  ),
                ),
              ],
              setHeightSpace(20),
              SocialMedia(),
            ],
          );
        },
      ),
    );
  }
}
