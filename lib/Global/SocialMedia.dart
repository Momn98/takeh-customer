// ignore_for_file: deprecated_member_use

import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  final bool showWebSite;
  SocialMedia({this.showWebSite = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarProvider>(
      builder: (_, v, __) {
        return Container(
          padding: EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ((v.setting.contact_phone.length > 0) ||
                  (v.setting.facebook_link.length > 0) ||
                  (v.setting.instagram_link.length > 0) ||
                  (v.setting.snapchat_link.length > 0) ||
                  (v.setting.messenger_link.length > 0) ||
                  (v.setting.contact_whats_app.length > 0))
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: Colors.black)),
                    setWithSpace(20),
                    globalText(
                      S.current.followUsOn,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    setWithSpace(20),
                    Expanded(child: Container(height: 1, color: Colors.black)),
                  ],
                ),
              //
              setHeightSpace(30),
              //
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  if (v.setting.contact_phone.length > 2)
                    socilaMediaIcon(SocialImage.phone,
                        () => launch('tel:${v.setting.contact_phone}')),
                  //
                  if (v.setting.facebook_link.length > 2)
                    socilaMediaIcon(SocialImage.facebook,
                        () => launch(v.setting.facebook_link)),
                  if (v.setting.instagram_link.length > 2)
                    socilaMediaIcon(SocialImage.instagram,
                        () => launch(v.setting.instagram_link)),
                  if (v.setting.messenger_link.length > 2)
                    socilaMediaIcon(SocialImage.messenger,
                        () => launch(v.setting.messenger_link)),
                  if (v.setting.contact_whats_app.length > 2)
                    socilaMediaIcon(
                      SocialImage.whatsapp,
                      () async {
                        WhatsAppUnilink link = WhatsAppUnilink(
                          phoneNumber: v.setting.contact_whats_app,
                        );
                        await launch('$link');
                      },
                      height: 35,
                      width: 35,
                    ),

                  //

                  socilaMediaIcon(
                    CircleAvatar(
                      child: Center(
                        child: Icon(Icons.share, color: Colors.white),
                      ),
                      backgroundColor: AppColor.orange,
                    ),
                    () => FlutterShare.share(
                      title: S.current.shareAppNow,
                      text: S.current.shareAppNow,
                    ),
                  ),
                ],
              ),
              //
              if (v.setting.web_site_link.length > 0) ...[
                setHeightSpace(15),
                InkWell(
                  onTap: () => launch('https://${v.setting.web_site_link}'),
                  child: Text(
                    v.setting.web_site_link,
                    style: TextStyle(color: AppColor.secondary),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget socilaMediaIcon(var image, function,
      {double width = 30, double height = 30}) {
    Widget? child;
    if (image is AssetImage) {
      child = Image(image: image, fit: BoxFit.cover);
    } else {
      child = image;
    }
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: Center(child: child),
        width: width,
        height: height,
      ),
    );
  }
}
