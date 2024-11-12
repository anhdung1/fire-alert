import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveApiKey(String apiKey) async {
    final SharedPreferences prefs = await getPrefs();
    await prefs.setString("apiKey", apiKey);
  }

  static Future<String> getApiKey() async {
    final SharedPreferences prefs = await getPrefs();
    return prefs.getString("apiKey") ?? "apikey not found";
  }

  static Future<void> removeApiKey() async {
    final SharedPreferences prefs = await getPrefs();
    prefs.remove("apiKey");
  }
}
