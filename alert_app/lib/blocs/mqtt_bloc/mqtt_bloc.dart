import 'dart:async';

import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mqtt_state.dart';
part 'mqtt_event.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttRepository mqttRepository;
  MqttBloc(this.mqttRepository) : super(MqttInitalState()) {
    on<MqttReconnectEvent>(_reconnect);
    on<MqttConnectEvent>(_connect);
    on<MqttSubcribeTopic>(_subscriptions);
  }

  FutureOr<void> _connect(
      MqttConnectEvent event, Emitter<MqttState> emit) async {
    emit(MqttConnectingState());

    await (mqttRepository.connectToBroker());
    if (mqttRepository.isConnected()) {
      await mqttRepository.subscribeTopic(event.sensors);
      mqttRepository.receivedMessage();
    }
    mqttRepository.receivedMessage().listen((data) {
      print(data.ppm);
    });
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      add(MqttReconnectEvent(sensors: event.sensors));
    });
  }

  FutureOr<void> _subscriptions(
      MqttSubcribeTopic event, Emitter<MqttState> emit) async {
    mqttRepository.subscribeTopic(event.sensors);
    mqttRepository.receivedMessage();
  }

  FutureOr<void> _reconnect(
      MqttReconnectEvent event, Emitter<MqttState> emit) async {
    if (!mqttRepository.isConnected()) {
      await mqttRepository.connectToBroker();
      if (mqttRepository.isConnected()) {
        add(MqttSubcribeTopic(sensors: event.sensors));
        return emit(MqttConnectedState());
      }
      emit(MqttConnectioFailure());
    }
    print("đã chạy qua để thửu");
  }
}
