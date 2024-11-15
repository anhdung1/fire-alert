import 'dart:async';

import 'package:alert_app/models/alert_model.dart';
import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mqtt_state.dart';
part 'mqtt_event.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  final MqttRepository mqttRepository;
  MqttBloc(this.mqttRepository) : super(MqttInitalState()) {
    on<MqttReconnectEvent>(_reconnect);
    on<MqttConnectEvent>(_connect);
    on<MqttSubcribeTopic>(_subscriptions);
    on<MqttDisplayEvent>(_display);
  }

  FutureOr<void> _connect(
      MqttConnectEvent event, Emitter<MqttState> emit) async {
    emit(MqttConnectingState());

    await (mqttRepository.connectToBroker());
    if (mqttRepository.isConnected()) {
      await mqttRepository.subscribeTopic(event.sensors);
      mqttRepository.receivedMessage();
    }
    mqttRepository.getStreamMessage().listen((data) {
      add(MqttDisplayEvent(alertModel: data, sensors: event.sensors));
    });
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      add(MqttReconnectEvent(sensors: event.sensors));
    });
  }

  FutureOr<void> _subscriptions(
      MqttSubcribeTopic event, Emitter<MqttState> emit) async {
    await mqttRepository.subscribeTopic(event.sensors);
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
  }

  FutureOr<void> _display(MqttDisplayEvent event, Emitter<MqttState> emit) {
    emit(MqttReceivedState(alertModel: event.alertModel));
  }
}
