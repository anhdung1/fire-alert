import 'package:alert_app/services/json_serializable.dart';

class LoginResponse extends JsonSerializable {
  final String apiKey;
  final String role;

  LoginResponse({required this.apiKey, required this.role});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        apiKey: json["apiKey"] ?? "", role: json["role"] ?? "ROLE_USER");
  }
}
