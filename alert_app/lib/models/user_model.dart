import 'dart:convert';

import 'package:alert_app/services/json_serializable.dart';

class UserModel extends JsonSerializable {
  final int id;
  final String address;
  final String phoneNumber;
  final String email;
  final String name;

  UserModel(
      {required this.id,
      required this.address,
      required this.phoneNumber,
      required this.email,
      required this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"] ?? -1,
        address: json["address"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        email: json["email"] ?? "",
        name: json["name"] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "address": address,
      "phoneNumber": phoneNumber,
      "email": email,
      "name": name
    };
  }

  String toJson() => jsonEncode(toMap());
}
