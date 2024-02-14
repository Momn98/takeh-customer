import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Fcm {
  // static String _serverKey = '';
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static _iosPermission() {
    _fcm.requestPermission();
  }

  static initConfigure(BuildContext context,
      {bool withOnMessage = true, bool onMessageOpenedApp = true}) {
    if (Platform.isIOS) _iosPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationService.showNotification(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
        );

        // printLog("message.data -> ${message.data['is_popup']}");
        if (message.data['is_popup'] == 'true') {
          chooseYesNoDialog(context, "${message.notification!.body}",
              yesText: S.current.close, showNo: false);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // printLog("message.data -> ${message.data['is_popup']}");
      NotificationService.showNotification(
        title: message.notification!.title.toString(),
        body: message.notification!.body.toString(),
      );

      if (message.data['is_popup'] == 'true') {
        chooseYesNoDialog(context, "${message.notification!.body}",
            yesText: S.current.close, showNo: false);
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        NotificationService.showNotification(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
        );

        // printLog("message.data -> ${message.data['is_popup']}");
        if (message.data['is_popup'] == 'true') {
          chooseYesNoDialog(context, "${message.notification!.body}",
              yesText: S.current.close, showNo: false);
        }
      }
    });
  }

  // static Future<String?> getUserToken() =>
  //     FirebaseMessaging.instance.getToken();
}

class NotificationService {
  static Future<void> initializeNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
        alert: true, announcement: false, badge: true, sound: true);

    await AwesomeNotifications().initialize(
      'resource://mipmap/launch_icon',
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Notifications',
          channelDescription: 'Notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
          // icon: 'assets/logo/logo.png',
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    printLog('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    printLog('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    printLog('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    printLog('onActionReceivedMethod');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      // MainApp.navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (_) => const SecondScreen(),
      //   ),
      // );
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
