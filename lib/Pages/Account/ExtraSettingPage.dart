import 'package:takeh_customer/Pages/Stander-Pages/ContactUs.dart';
import 'package:takeh_customer/Pages/Stander-Pages/DeleteAccountPage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/LanguagePage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/NotificationListPage.dart';
import 'package:takeh_customer/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:takeh_customer/main.dart';

class ExtraSettingPage extends StatefulWidget {
  const ExtraSettingPage({Key? key}) : super(key: key);
  @override
  State<ExtraSettingPage> createState() => _ExtraSettingPageState();
}

class _ExtraSettingPageState extends State<ExtraSettingPage> {
  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(text: S.current.settings),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // settingIcon(
                  //   Icons.person_outline,
                  //   S.current.profile,
                  //   () => NavMove.goToPage(context, ProfilePage(),
                  //       mustLogin: true),
                  // ),
                  settingIcon(
                    Icons.notifications_outlined,
                    S.current.notifications,
                    () => NavMove.goToPage(context, NotificationListPage(),
                        mustLogin: true),
                  ),
                  settingIcon(
                    Icons.language_outlined,
                    S.current.language,
                    () => NavMove.goToPage(context, LanguagePage()),
                  ),
                  settingIcon(
                    Icons.support_agent,
                    S.current.contactUs,
                    () => NavMove.goToPage(context, ContactUsPage()),
                  ),

                  // settingIcon(
                  //   Icons.info_outline,
                  //   S.current.aboutApp,
                  //   () =>
                  //       NavMove.goToPage(context, PoliciesPage(page: 'about')),
                  // ),

                  //
                  settingIcon(
                    Icons.privacy_tip,
                    S.current.privacyPolicy,
                    () => NavMove.goToPage(
                        context, PoliciesPage(page: 'privacy')),
                  ),
                  //
                  settingIcon(
                    Icons.edit_note,
                    S.current.termsAndCondition,
                    () =>
                        NavMove.goToPage(context, PoliciesPage(page: 'terms')),
                  ),
                  //
                  // settingIcon(
                  //   Icons.help,
                  //   S.current.help,
                  //   () => NavMove.goToPage(context, PoliciesPage(page: 'help')),
                  // ),
                  // //

                  settingIcon(
                    Icon(Icons.delete_forever, color: Colors.red),
                    S.current.deleteAccount,
                    () => NavMove.goToPage(context, DeleteAccountPage()),
                  ),
                ],
              ),
            ),
          ),

          // settingIcon(
          //   Kimages.profileContactIcon,
          //   S.current.contactUs,
          //   () => NavMove.goToPage(context, ContactUsPage()),
          // ),

          globalText(
            '${S.current.version}: V.${tabBarProvider.setting.app_version}',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          globalText(
            '${S.current.copyright} © ${S.current.appName} 2023.\n${S.current.allRightsReserved}.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),

          setHeightSpace(10),
        ],
      ),
    );
  }

  Widget settingIcon(image, String name, Function()? toDo) {
    return GestureDetector(
      onTap: toDo,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: 15),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(8, 15, 20, 15),
          child: Row(
            children: [
              SizedBox(width: 20),
              if (image is AssetImage) ...[
                Image(image: image, height: 20),
              ] else if (image is IconData) ...[
                Icon(image)
              ] else if (image is Icon) ...[
                image
              ] else ...[
                SvgPicture.asset(
                  image,
                  color: Colors.black,
                  height: 20,
                ),
              ],
              SizedBox(width: 20),
              globalText(
                name,
                style: TextStyle(
                  color: AppColor.secondary,
                  fontSize: 17,
                ),
              ),
              Spacer(),
              Icon(
                Icons.navigate_next,
                color: AppColor.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
