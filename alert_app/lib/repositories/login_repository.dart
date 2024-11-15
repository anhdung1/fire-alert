import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/models/login_response.dart';
import 'package:alert_app/services/login_service.dart';
import 'package:alert_app/services/result.dart';

class LoginRepository {
  final LoginService loginService;
  final PreferenceHelper preferenceHelper;

  LoginRepository({required this.loginService, required this.preferenceHelper});

  Future<Result<LoginResponse>> login(String username, String password) async {
    Result<LoginResponse> result = await loginService.login(username, password);
    if (result.isSuccess) {
      final apiKey = result.data?.apiKey;
      if (apiKey != null) {
        await preferenceHelper.saveApiKey(apiKey);
      }
    }

    return result;
  }
}
