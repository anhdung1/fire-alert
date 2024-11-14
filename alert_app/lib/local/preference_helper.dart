import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveLoginStatus(String? role, String apiKey) async {
    final SharedPreferences prefs = await getPrefs();
    prefs.setString("apiKey", apiKey);
    prefs.setBool("isLoggedIn", true);
    prefs.setString("role", role ?? "ROLE_USER");
  }

  static Future<void> removeLoginStatus() async {
    final SharedPreferences prefs = await getPrefs();
    prefs.clear();
  }

  static Future<String> getRole() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString("role") ?? "ROLE_USER";
  }

  static Future<String> getApiKey() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString("apiKey") ?? "apikey not found";
  }

  static Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getBool("isLoggedIn") ?? false;
  }
}
