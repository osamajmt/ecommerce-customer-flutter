import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';

requestNotiPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
  print('User granted permission: ${settings.authorizationStatus}');
}

fcmconfig() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message: ${message.notification?.title}');
    print('Got a message: ${message.notification?.body}');
  FlutterRingtonePlayer().playNotification();
    Get.snackbar(
      '${message.notification?.title}',
      '${message.notification?.body}',
    );
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('User clicked on notification');
  });
}
