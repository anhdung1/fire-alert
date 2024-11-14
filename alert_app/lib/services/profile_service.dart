import 'package:alert_app/models/sensor_response.dart';
import 'package:alert_app/models/user_model.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/json_to_object.dart';
import 'package:alert_app/services/result.dart';

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

  Future<Result<List<SensorResponse>>> getTopic() async {
    return await apiService.jsonHandleGetMapping(
        SensorResponse.fromJson, "users/topic-subscribed");
  }

  Future<Result<List<SensorResponse>>> getAllTopic() async {
    return await apiService.jsonHandleGetMapping(
        SensorResponse.fromJson, "admin/all-topic");
  }
}
