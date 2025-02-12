import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print('Title: ${message.notification?.title}');
  }
  if (kDebugMode) {
    print('Body: ${message.notification?.body}');
  }
  if (kDebugMode) {
    print('Payload: ${message.data}');
  }
}

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('Token: $fCMToken');
    }
  }
}
