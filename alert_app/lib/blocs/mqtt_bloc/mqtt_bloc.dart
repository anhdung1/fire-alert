import 'dart:async';

import 'package:alert_app/models/alert_response.dart';
import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/repositories/mqtt_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mqtt_state.dart';
part 'mqtt_event.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  Timer? _timer;
  List<AlertResponse> alertResponseSet = [];
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
    for (int i = 0; i < event.sensors.length; i++) {
      AlertResponse alertResponse = AlertResponse(
          ppm: "đang đợi",
          fire: false,
          temperature: "đang đợi",
          topic: event.sensors[i].topic);
      alertResponseSet.add(alertResponse);
    }
    await (mqttRepository.connectToBroker());
    if (mqttRepository.isConnected()) {
      await mqttRepository.subscribeTopic(event.sensors);

      mqttRepository.receivedMessage();
      emit(MqttReceivedState(alertResponse: alertResponseSet));
    }
    mqttRepository.getStreamMessage().listen((data) {
      // alertResponseSet.add(data);
      int index =
          alertResponseSet.indexWhere((item) => item.topic == data.topic);
      if (index != -1) {
        alertResponseSet.removeAt(index);
        alertResponseSet.insert(index, data);
      }
      add(MqttDisplayEvent(
          alertResponse: alertResponseSet, sensors: event.sensors));
    });
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
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
        return emit(MqttReceivedState(alertResponse: alertResponseSet));
      }
      emit(MqttConnectioFailure());
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    mqttRepository.mqttService.client.disconnect();
    return super.close();
  }

  FutureOr<void> _display(MqttDisplayEvent event, Emitter<MqttState> emit) {
    // emit(MqttConnectingState());
    emit(MqttReceivedState(alertResponse: event.alertResponse));
  }
}
