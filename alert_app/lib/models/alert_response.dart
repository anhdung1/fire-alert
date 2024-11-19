import 'package:alert_app/services/json_serializable.dart';
import 'package:equatable/equatable.dart';

class AlertResponse extends Equatable implements JsonSerializable {
  final String ppm;
  final bool fire;
  final String temperature;
  final String topic;

  const AlertResponse(
      {required this.ppm,
      required this.fire,
      required this.temperature,
      required this.topic});
  factory AlertResponse.fromJson(Map<String, dynamic> json, String topic) =>
      AlertResponse(
          ppm: json["ppm"] ?? " ",
          fire: json["fire"] ?? false,
          temperature: json["temperature"] ?? "0",
          topic: topic);

  @override
  List<Object?> get props => [topic];
}
