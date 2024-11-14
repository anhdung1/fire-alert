part of 'mqtt_bloc.dart';

abstract class MqttState {}

class MqttInitalState extends MqttState {}

class MqttConnectingState extends MqttState {}

class MqttConnectedState extends MqttState {}

class MqttConnectioFailure extends MqttState {}
