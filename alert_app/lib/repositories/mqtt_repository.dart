import 'package:alert_app/models/alert_response.dart';
import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/services/mqtt_service.dart';

class MqttRepository {
  final MqttService mqttService;

  MqttRepository({required this.mqttService});

  Future<bool> connectToBroker() async {
    await mqttService.connect();
    return mqttService.isConnected();
  }

  Future<void> subscribeTopic(List<SensorResponse> sensors) async {
    for (int i = 0; i < sensors.length; i++) {
      await mqttService.subscribe(sensors[i].topic);
      mqttService.isSubscribed(sensors[i].topic);
    }
  }

  bool isConnected() {
    return mqttService.isConnected();
  }

  void receivedMessage() {
    mqttService.listenMessage();
  }

  Stream<AlertResponse> getStreamMessage() {
    return mqttService.alertStream;
  }
}
