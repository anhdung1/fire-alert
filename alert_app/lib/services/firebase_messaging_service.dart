import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  StreamSubscription<RemoteMessage>? _messageSubscription;
  static Future<String> configureFirebase() async {
    String? deviceToken = await _firebaseMessaging.getToken();

    return deviceToken ?? "";
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
    _messageSubscription =
        FirebaseMessaging.onMessage.listen((RemoteMessage data) {});
  }

  void disconnectOnMessage() {
    if (_messageSubscription != null) _messageSubscription!.cancel();
  }

  static Future<void> deleteToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }
}
