import 'dart:convert';
import 'dart:developer';

import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/json_serializable.dart';
import 'package:alert_app/services/json_to_object.dart';
import 'package:alert_app/services/result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String> headers(String apiKey) {
    return {
      'Content-Type': 'application/json',
      'x-api-key': apiKey.toString(),
    };
  }

  final client = http.Client();
  getMapping(String url) async {
    return await client.get(Uri.parse("http://${Constant.ip}:8080/$url"),
        headers: headers(await PreferenceHelper.getApiKey()));
  }

  patchMapping(String url, body) async {
    return await client.patch(Uri.parse("http://${Constant.ip}:8080/$url"),
        headers: headers(await PreferenceHelper.getApiKey()),
        body: jsonEncode(body));
  }

  postMapping(String url, body) async {
    return await client.post(Uri.parse("http://${Constant.ip}:8080/$url"),
        headers: headers(await PreferenceHelper.getApiKey()),
        body: jsonEncode(body));
  }

  putMapping(String url, body) async {
    return await client.put(Uri.parse("http://${Constant.ip}:8080/$url"),
        headers: headers(await PreferenceHelper.getApiKey()),
        body: jsonEncode(body));
  }

  Future jsonHandlePutMapping<T>(
      T Function(Map<String, dynamic>) fromJson, String url, body) async {
    try {
      var response = await putMapping(url, body);
      if (response.statusCode == 200) {
        return JsonToObject.jsonToList(response, fromJson);
      } else {
        return "Failed to load data: ${HttpError.getErrorMessage(response.statusCode)}";
      }
    } catch (e) {
      log("Error occurred: $e");
      return ("Error fetching data");
    }
  }

  Future jsonHandlePatchMapping<T>(
      T Function(Map<String, dynamic>) fromJson, String url, body) async {
    try {
      var response = await patchMapping(url, body);
      if (response.statusCode == 200) {
        return JsonToObject.jsonToList(response, fromJson);
      } else {
        return "Failed to load data: ${HttpError.getErrorMessage(response.statusCode)}";
      }
    } catch (e) {
      log("Error occurred: $e");
      return ("Error fetching data");
    }
  }

  Future<Result<List<T>>> jsonHandleGetMapping<T extends JsonSerializable>(
      T Function(Map<String, dynamic>) fromJson, String url) async {
    try {
      var response = await getMapping(url);
      if (response.statusCode == 200) {
        var result = JsonToObject.jsonToList(response, fromJson);

        return Result(data: result);
      } else {
        return Result(
            error:
                "Failed to load data: ${HttpError.getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      log("Error occurred: $e");
      return Result(error: "$e");
    }
  }

  Future<Result<List<T>>> jsonHandlePostMapping<T extends JsonSerializable>(
      T Function(Map<String, dynamic>) fromJson, String url, body) async {
    try {
      var response = await postMapping(url, body);
      if (response.statusCode == 200) {
        var result = JsonToObject.jsonToList(response, fromJson);
        return Result(data: result);
      } else {
        return Result(
            error:
                "Failed to load data: ${HttpError.getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      log("Error occurred: $e");
      return Result(error: "$e");
    }
  }
}
