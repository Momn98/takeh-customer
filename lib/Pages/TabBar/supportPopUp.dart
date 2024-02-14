import 'package:takeh_customer/Global/SocialMedia.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

supportPopUp(BuildContext context) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return SupportWidget();
    },
  );
}

class SupportWidget extends StatelessWidget {
  const SupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<TabBarProvider>(
        builder: (_, v, __) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                setHeightSpace(10),
                Stack(
                  children: [
                    Center(
                      child: globalText(
                        S.current.support,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () => NavMove.closeDialog(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalText(
                          S.current.contactUsTextLong,
                          style: TextStyle(fontSize: 18),
                        ),
                        setHeightSpace(20),
                      ],
                    ),
                  ),
                ),
                //
                SocialMedia(),
                //
                setHeightSpace(20),
                //
                Container(
                  width: double.infinity,
                  child: globalButton(
                    S.current.Continue,
                    () async {
                      WhatsAppUnilink link = WhatsAppUnilink(
                        phoneNumber: v.setting.contact_whats_app,
                        text: '',
                      );
                      // ignore: deprecated_member_use
                      await launch(link.toString());
                    },
                    fontWeight: FontWeight.normal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    backColor: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),
                //
                setHeightSpace(25),
              ],
            ),
          );
        },
      ),
    );
  }
}
