import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Pages/Account/ExtraSettingPage.dart';
import 'package:takeh_customer/Pages/Account/ProfilePage.dart';
import 'package:takeh_customer/Pages/Auth/AuthView.dart';
import 'package:takeh_customer/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:takeh_customer/Pages/Wallet/WalletCard.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    authProvider.getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      showBackground: false,
      appBar: HomeAppBar(
        preferredSize: Size.fromHeight(0),
        color: Colors.transparent,
        elevation: 0,
      ),
      vertical: 0,
      horizontal: 0,
      body: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: WalletCard(),
              ),
              setHeightSpace(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (v.isLogIn)
                        Row(
                          children: [
                            setWithSpace(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  globalText(v.user.name),
                                  setHeightSpace(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: globalText(v.user.phone),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: v.isLogIn
                                    ? NetworkImagePlace(
                                        image: v.user.image,
                                        fit: BoxFit.cover,
                                        all: 90,
                                      )
                                    : Image(image: LogoImage.logo),
                              ),
                            ),
                            setWithSpace(20),
                          ],
                        ),

                      if (v.isLogIn)
                        Container(
                          padding: EdgeInsetsDirectional.only(start: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setHeightSpace(10),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: v.user.rate,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  onRatingUpdate: (rating) => null,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                                ),
                              ),
                              setHeightSpace(10),
                              globalText(
                                  '${S.current.yourTotalPoints}: ${v.user.points.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),

                      setHeightSpace(30),
                      // settingIcon(
                      //     IconImage.history, S.current.rideHistory, () {
                      //   Scaffold.of(context).closeDrawer();
                      //   NavMove.goToPage(context, RideHistoryPage(),
                      //       mustLogin: true);
                      // }),

                      settingIcon(
                        Icons.account_circle_outlined,
                        S.current.account,
                        () => NavMove.goToPage(context, ProfilePage(),
                            mustLogin: true),
                      ),

                      settingIcon(
                        Icons.settings_outlined,
                        S.current.settings,
                        () => NavMove.goToPage(context, ExtraSettingPage()),
                      ),

                      settingIcon(Icons.share_outlined, S.current.shareApp, () {
                        FlutterShare.share(
                          title: S.current.shareAppNow,
                          text: S.current.shareAppNow,
                          linkUrl: tabBarProvider.setting.share_link + '/share',
                        );
                      }),

                      settingIcon(
                        Icons.info_outline,
                        S.current.aboutApp,
                        () => NavMove.goToPage(
                            context, PoliciesPage(page: 'about-app')),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  setHeightSpace(20),
                  if (v.isLogIn)
                    settingIcon(
                      Icons.login_outlined,
                      S.current.signOut,
                      () => v.logOut(context),
                      color: Colors.grey,
                      under: false,
                      arrow: false,
                      iconColor: Colors.red,
                    )
                  else
                    settingIcon(
                      Icons.power_settings_new_outlined,
                      S.current.logIn,
                      () => NavMove.goToPage(context, AuthView()),
                      iconColor: Colors.green,
                      under: false,
                      arrow: false,
                    ),

                  //
                  InkWell(
                    onTap: () =>
                        NavMove.goToPage(context, PoliciesPage(page: 'terms')),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: globalText(
                              S.current.termsAndCondition,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          globalText(
                            '${S.current.appName} 2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget settingIcon(
    var image,
    String? name,
    Function()? toDo, {
    String? extraText,
    Color? extraColor,
    Color? color,
    Color? iconColor,
    bool under = true,
    bool arrow = true,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: toDo,
        child: Container(
          // decoration: BoxDecoration(
          //   border: under ? Border(bottom: BorderSide(width: 0.4)) : null,
          // ),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image is AssetImage) ...[
                Image(image: image, height: 25),
              ] else if (image is IconData) ...[
                Icon(image, color: iconColor ?? Colors.black)
              ] else if (image is Icon) ...[
                image
              ] else if (image.contains('.svg')) ...[
                SvgPicture.asset(
                  image,
                  color: iconColor ?? AppColor.secondary,
                  height: 35,
                  width: 20,
                ),
              ],
              setWithSpace(15),
              if (name != null)
                globalText(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              setWithSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}
