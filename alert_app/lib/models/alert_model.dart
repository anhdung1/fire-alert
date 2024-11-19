import 'package:alert_app/services/json_serializable.dart';

class AlertModel extends JsonSerializable {
  final String alertTime;
  final double ppm;
  final double temperature;
  final String location;

  AlertModel(
      {required this.alertTime,
      required this.ppm,
      required this.temperature,
      required this.location});
  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
      alertTime: json["alertTime"] ?? "",
      ppm: json["ppm"] ?? 0.0,
      temperature: json["alertTime"] ?? 0.0,
      location: json["location"] ?? "");
}
