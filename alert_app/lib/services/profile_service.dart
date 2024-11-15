import 'dart:convert';

import 'package:alert_app/models/user_model.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/json_to_object.dart';
import 'package:alert_app/services/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProfileService {
  final ApiService apiService;

  ProfileService({required this.apiService});
  Future<Result<UserModel>> getUser() async {
    try {
      Response response = await apiService.getMapping("user-info/get");
      if (response.statusCode == 200) {
        return Result(
            data: JsonToObject.jsonToItem(response, UserModel.fromJson));
      }
      return Result(error: HttpError.getErrorMessage(response.statusCode));
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<Result<UserModel>> updateUser(UserModel user) async {
    try {
      Response response =
          await apiService.putMapping("user-info/update", user.toMap());
      if (response.statusCode == 200) {
        return Result(
            data: JsonToObject.jsonToItem(response, UserModel.fromJson));
      }
      return Result(error: HttpError.getErrorMessage(response.statusCode));
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<Result<List<String>>> getTopic() async {
    try {
      Response response = await apiService.getMapping("topic-subscribed");
      if (response.statusCode == 200) {
        List<String> result = jsonDecode(response.body);
        return Result(data: result);
      }
      return Result(error: HttpError.getErrorMessage(response.statusCode));
    } catch (e) {
      debugPrint("Lỗi ở getTopic");
      return Result(error: e.toString());
    }
  }
}
