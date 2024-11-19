import 'package:alert_app/models/sensor_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveLoginStatus(
      String? role, String apiKey, int userId) async {
    final SharedPreferences prefs = await getPrefs();
    prefs.setString("apiKey", apiKey);
    prefs.setBool("isLoggedIn", true);
    prefs.setString("role", role ?? "ROLE_USER");
    prefs.setInt("userId", userId);
  }

  static Future<void> removeLoginStatus() async {
    final SharedPreferences prefs = await getPrefs();
    prefs.clear();
  }

  static Future<String> getRole() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString("role") ?? "ROLE_USER";
  }

  static Future<int> getUserId() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getInt("userId") ?? -1;
  }

  static Future<String> getApiKey() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString("apiKey") ?? "apikey not found";
  }

  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  static Future<void> saveTopic(List<SensorResponse> sensors) async {
    List<String> topics = [];
    for (int i = 0; i < sensors.length; i++) {
      topics.add(sensors[i].topic);
    }
    final SharedPreferences prefs = await getPrefs();
    prefs.setStringList("topic", topics);
  }

  static Future<List<String>> getSensor() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getStringList("sensor") ?? [];
  }
}
