import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/models/login_response.dart';
import 'package:alert_app/services/login_service.dart';
import 'package:alert_app/services/result.dart';

class LoginRepository {
  final LoginService loginService;

  LoginRepository({required this.loginService});

  Future<Result<LoginResponse>> login(String username, String password) async {
    Result<LoginResponse> result = await loginService.login(username, password);
    if (result.isSuccess) {
      await PreferenceHelper.saveLoginStatus(
          result.data!.role, result.data!.apiKey);
    }

    return result;
  }
}
