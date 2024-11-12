import 'dart:convert';

import 'package:http/http.dart' as http;

class JsonToObject {
  static List<T> jsonToList<T>(
      http.Response response, T Function(Map<String, dynamic> json) fromJson) {
    try {
      List result = jsonDecode(utf8.decode(response.bodyBytes));
      List<T> dataList = [];
      for (int i = 0; i < result.length; i++) {
        var data = fromJson(result[i] as Map<String, dynamic>);
        dataList.add(data);
      }
      return dataList;
    } catch (e) {
      throw Exception(e.toString());
      // debugPrint(e.toString());
    }
  }

  static T jsonToItem<T>(
      http.Response response, T Function(Map<String, dynamic> json) fromJson) {
    try {
      var result = jsonDecode(utf8.decode(response.bodyBytes));

      var data = fromJson(result as Map<String, dynamic>);

      return data;
    } catch (e) {
      throw Exception("lỗi ở jsonToItem $e");
    }
  }
}
