import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> configureFirebase() async {
    String? deviceToken = await _firebaseMessaging.getToken();

    log("token: ${deviceToken ?? "null"}");
  }

  Future<void> setting() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void receivedMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage data) {});
  }
}
