import 'package:alert_app/services/json_serializable.dart';

class AlertModel extends JsonSerializable {
  final String ppm;
  final bool fire;
  final String temperature;

  AlertModel(
      {required this.ppm, required this.fire, required this.temperature});
  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
      ppm: json["ppm"] ?? " ",
      fire: json["fire"] ?? false,
      temperature: json["temperature"] ?? "0");
}
