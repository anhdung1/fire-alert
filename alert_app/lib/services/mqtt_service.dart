import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/models/alert_response.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final MqttServerClient client;

  MqttService() : client = MqttServerClient(Constant.ip.toString(), "client");
  final StreamController<AlertResponse> _alertController =
      StreamController<AlertResponse>();

  Stream<AlertResponse> get alertStream => _alertController.stream;
  Future<void> connect() async {
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
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      for (var message in messages) {
        final MqttPublishMessage recMessage =
            message.payload as MqttPublishMessage;
        final String payload = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);

        try {
          AlertResponse alertModel = AlertResponse.fromJson(
              jsonDecode(payload) as Map<String, dynamic>, message.topic);
          _alertController.add(alertModel);
          debugPrint("add success");
        } catch (e) {
          debugPrint("add failure");
          debugPrint(e.toString());
        }
      }
    });
  }

  Future<void> closeListenMessage() async {
    await _alertController.close();
  }
  // Stream<List<MqttReceivedMessage<MqttMessage>>> get messages =>
  //     client.updates!;
}
