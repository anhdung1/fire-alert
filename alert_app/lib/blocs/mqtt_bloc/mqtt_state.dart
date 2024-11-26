part of 'mqtt_bloc.dart';

abstract class MqttState {}

class MqttInitalState extends MqttState {}

class MqttConnectingState extends MqttState {}

class MqttConnectionFailure extends MqttState {
  final String error;

  MqttConnectionFailure({required this.error});
}

class MqttReceivedState extends MqttState {
  final List<AlertResponse> alertResponse;

  MqttReceivedState({required this.alertResponse});
}
