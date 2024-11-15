part of 'mqtt_bloc.dart';

abstract class MqttState {}

class MqttInitalState extends MqttState {}

class MqttConnectingState extends MqttState {}

class MqttConnectedState extends MqttState {}

class MqttConnectioFailure extends MqttState {}

class MqttReceivedState extends MqttState {
  final AlertModel alertModel;

  MqttReceivedState({required this.alertModel});
}
