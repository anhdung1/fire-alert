import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alert_app/models/alert_model.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final MqttServerClient client;

  MqttService() : client = MqttServerClient("localhost", "client");
  final StreamController<AlertModel> _alertController =
      StreamController<AlertModel>.broadcast();

  Stream<AlertModel> get alertStream => _alertController.stream;
  Future<void> connect() async {
    // client.port = 1883;
    // client.logging(on: true);
    client.keepAlivePeriod = 1120;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.setProtocolV311();

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      debugPrint('EXAMPLE::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      debugPrint('EXAMPLE::socket exception - $e');
      client.disconnect();
    }
  }

  bool isConnected() {
    return client.connectionStatus?.state == MqttConnectionState.connected;
  }

  Future subscribe(String topic) async {
    if (isConnected()) {
      client.subscribe(topic, MqttQos.atLeastOnce);
    } else {
      debugPrint('Client is not connected. Cannot subscribe.');
    }
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    if (isConnected()) {
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    } else {
      debugPrint('Client is not connected. Cannot publish message.');
    }
  }

  void onConnected() {
    debugPrint('MQTT Connected');
  }

  void isSubscribed(String topic) {
    var status = client.getSubscriptionsStatus(topic);
    debugPrint(status.toString());
  }

  void onDisconnected() {
    debugPrint('MQTT Disconnected');
  }

  void listenMessage() {
    messages.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (var message in messages) {
        final MqttPublishMessage recMessage =
            message.payload as MqttPublishMessage;
        final String payload = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);
        print(payload.toString());
        try {
          AlertModel alertModel =
              AlertModel.fromJson(jsonDecode(payload) as Map<String, dynamic>);
          _alertController.add(alertModel);
          debugPrint("add success");
        } catch (e) {
          debugPrint("add failure");
          debugPrint(e.toString());
        }
      }
    });
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>> get messages =>
      client.updates!;
}
