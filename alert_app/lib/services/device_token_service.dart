import 'dart:developer';
import 'dart:io';

import 'package:alert_app/models/device_tokens_model.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/firebase_messaging_service.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/result.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart';

class DeviceTokenService {
  final ApiService apiService;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  DeviceTokenService({required this.apiService});
  Future<Result<String>> sendInfoDevice() async {
    try {
      Map<String, dynamic> deviceInfo = await getDeviceDetails();
      String deviceToken = await FirebaseMessagingService.configureFirebase();
      DeviceTokensModel deviceTokensModel = DeviceTokensModel(
          deviceToken: deviceToken,
          deviceId: deviceInfo["deviceId"],
          deviceName: deviceInfo["deviceName"]);
      Response response = await apiService.postMapping(
          "device-token/send", deviceTokensModel.toMap());
      if (response.statusCode == 200) {
        return Result(data: response.body);
      }
      return Result(error: HttpError.getErrorMessage(response.statusCode));
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<void> deleteDeviceToken() async {
    try {
      await FirebaseMessagingService.deleteToken();
      Map<String, dynamic> deviceInfo = await getDeviceDetails();
      await apiService.deleteMapping(
          "device-token/delete?deviceId=${deviceInfo["deviceId"]}", {});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDeviceDetails() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      Map<String, dynamic> info = {
        'deviceId': androidInfo.id,
        'deviceName': androidInfo.model,
      };
      return info;
    } else {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        'deviceId': iosInfo.identifierForVendor,
        'deviceName': iosInfo.name,
      };
    }
  }
}
