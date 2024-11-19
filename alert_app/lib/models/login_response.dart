import 'package:alert_app/services/json_serializable.dart';

class LoginResponse extends JsonSerializable {
  final String apiKey;
  final String role;
  final int userId;

  LoginResponse(
      {required this.apiKey, required this.role, required this.userId});
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        apiKey: json["apiKey"] ?? "",
        role: json["role"] ?? "ROLE_USER",
        userId: json["userId"] ?? -1);
  }
}
