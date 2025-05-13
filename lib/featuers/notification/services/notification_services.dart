import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';


class NotificationServices{
  FirebaseMessaging messaging =FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    try {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("User  granted permission");
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        print("User  granted provisional permission");
        Get.snackbar("Provisional Permission Granted",
            "You will receive notifications, but they may be limited.",
            snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Notification Permission Denied",
            "Please allow notifications to receive updates.",
            snackPosition: SnackPosition.TOP);
        Future.delayed(Duration(seconds: 2), () {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
        });
      }
    } catch (e) {
      print("Error requesting notification permission: $e");
      Get.snackbar("Error",
          "An error occurred while requesting notification permission.",
          snackPosition: SnackPosition.TOP);
    }
  }
  ///get token
  Future<String> getDeviceToken() async {
     /*NotificationSettings settings =*/ await messaging.requestPermission(
      announcement: true,
      alert: true,
      sound: true,
      badge: true,
    );
    String? token = await messaging.getToken();
print("Device-Token------->${token}");
    return token!;
  }


}