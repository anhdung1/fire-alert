import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;

  MqttService(String broker, int port) {
    client = MqttServerClient(broker, '');
    client.port = port;
    client.keepAlivePeriod = 20;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
  }

  // Hàm kết nối đến broker
  Future<void> connect() async {
    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier('FlutterClient')
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    try {
      await client.connect();
    } catch (e) {
      disconnect();
    }

    // Kiểm tra trạng thái kết nối
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
    } else {
      disconnect();
    }
  }

  // Hàm ngắt kết nối
  void disconnect() {
    client.disconnect();
  }

  // Hàm đăng ký vào một topic
  void subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  // Hàm gửi tin nhắn
  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  // Xử lý khi kết nối thành công
  void onConnected() {}

  // Xử lý khi ngắt kết nối
  void onDisconnected() {}

  // Xử lý khi đăng ký thành công vào một topic
  void onSubscribed(String topic) {}

  // Xử lý khi hủy đăng ký
  void onUnsubscribed(String? topic) {}

  // Xử lý khi đăng ký thất bại
  void onSubscribeFail(String topic) {}

  // Callback khi nhận được pong từ broker
  void pong() {}
}
