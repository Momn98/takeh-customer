import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Models/FirebaseNotification.dart';
import 'package:takeh_customer/Provider/HomeProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({Key? key}) : super(key: key);
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    homeProvider.clear();
    homeProvider.getNotifications();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        homeProvider.getNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(text: S.current.notifications),
      body: Consumer<HomeProvider>(
        builder: (_, v, __) {
          return Column(
            children: [
              Container(width: double.infinity, height: 0),
              if (v.notifications.length == 0) ...[
                // LoaderPlace(
                //   text: S.current.noNotificationsHere,
                //   loader: v.haveMore,
                // ),
                setHeightSpace(30),
                Center(child: globalText(S.current.noNotificationsHere)),
                setHeightSpace(30),
                if (v.haveMoreNotifications) CircularProgressIndicator(),
                //
              ] else if (v.notifications.length > 0) ...[
                Expanded(
                  child: SingleChildScrollView(
                    controller: _sc,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: v.notifications.length,
                      itemBuilder: (_, index) {
                        FirebaseNotification notification =
                            v.notifications[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              // if (notification.the_page == 'contact-us') {
                              //   NavMove.goToPage(context, ContactUsPage());
                              // } else if (notification.the_page == 'order') {
                              //   orderProvider.onOrder = notification.order;
                              //   NavMove.goToPage(context, OneOrderPage());
                              // }
                            },
                            child: Container(
                              padding: EdgeInsets.all(18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    IconSvg.notification,
                                    color: AppColor.orange,
                                    height: 30,
                                  ),
                                  setWithSpace(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        globalText(notification.title),
                                        globalText(notification.body),
                                        Divider(color: AppColor.orange),
                                        globalText(
                                          notification.created_ago,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
