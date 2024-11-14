import 'package:alert_app/services/json_serializable.dart';

class SensorResponse extends JsonSerializable {
  final int id;
  final String location;
  final String topic;

  SensorResponse(
      {required this.id, required this.location, required this.topic});
  factory SensorResponse.fromJson(Map<String, dynamic> json) {
    return SensorResponse(
        id: json["id"] ?? -1,
        location: json["location"] ?? "unknow",
        topic: json["topic"] ?? "");
  }
}
