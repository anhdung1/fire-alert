import 'package:alert_app/models/user_model.dart';
import 'package:alert_app/services/profile_service.dart';
import 'package:alert_app/services/result.dart';

class ProfileRepository {
  final ProfileService profileService;

  ProfileRepository({required this.profileService});
  Future<Result<UserModel>> getUser() {
    return profileService.getUser();
  }

  Future<Result<UserModel>> updateUser(UserModel user) {
    return profileService.updateUser(user);
  }
}
