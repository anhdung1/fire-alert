part of 'mqtt_bloc.dart';

abstract class MqttEvent {
  final List<SensorResponse> sensors;

  MqttEvent({required this.sensors});
}

class MqttConnectEvent extends MqttEvent {
  MqttConnectEvent({required super.sensors});
}

class MqttSubcribeTopic extends MqttEvent {
  MqttSubcribeTopic({required super.sensors});
}

class MqttReconnectEvent extends MqttEvent {
  MqttReconnectEvent({required super.sensors});
}

class MqttDisplayEvent extends MqttEvent {
  final List<AlertResponse> alertResponse;
  MqttDisplayEvent({required this.alertResponse, required super.sensors});
}
