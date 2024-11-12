import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:alert_app/models/login_response.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/json_to_object.dart';
import 'package:alert_app/services/result.dart';
import 'package:http/http.dart';

class LoginService {
  final ApiService apiService;

  LoginService({required this.apiService});
  Future<Result<LoginResponse>> login(String username, String password) async {
    try {
      Response response = await apiService.postMapping(
          "api/auth/login", {"username": username, "password": password});
      if (response.statusCode == 200) {
        var result = JsonToObject.jsonToItem(response, LoginResponse.fromJson);
        return Result(data: result);
      }
      if (response.statusCode == 400) {
        return Result(
            error: "Thông tin tài khoản hoặc mật khẩu không chính xác");
      }
      return Result(
          error:
              "Failed to load data: ${HttpError.getErrorMessage(response.statusCode)}");
    } on SocketException {
      return Result(error: "Lỗi máy chủ");
    } on TimeoutException {
      return Result(error: "Quá thời gian chờ");
    } catch (e) {
      log("Error occurred: $e");
      return Result(error: "$e");
    }
  }
}
