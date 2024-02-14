import UIKit
import Flutter
// import Firebase
import FirebaseCore
// import FirebaseMessaging
import GoogleMaps
// import PusherSwift
import awesome_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    // This function registers the desired plugins to be used within a notification background action
    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in          
        SwiftAwesomeNotificationsPlugin.register(
          with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)          
    }
    
    GMSServices.provideAPIKey("AIzaSyAobEHss6xoqoB16JBHZlkOkZ6QntH-AUk")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // // 👇 this block
  // override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  //   // NOTE: For logging
  //   // let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
  //   // print("==== didRegisterForRemoteNotificationsWithDeviceToken ====")
  //   // print(deviceTokenString)
  //   // Messaging.messaging().apnsToken = deviceToken
  // }
}