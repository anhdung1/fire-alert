import 'package:alert_app/local/database_helper.dart';
import 'package:alert_app/models/sensor_response.dart';
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

  Future<Result<List<SensorResponse>>> getAllTopic() async {
    Result<List<SensorResponse>> result = await profileService.getAllTopic();
    if (result.isSuccess) {
      List sensors = await DatabaseHelper.instance.queryAllSensors();
      if (sensors.isNotEmpty) return result;
      for (int i = 0; i < result.data!.length; i++) {
        await DatabaseHelper.instance.insertSensor(result.data![i]);
      }
    }
    return result;
  }

  Future<Result<List<SensorResponse>>> getTopic() {
    return profileService.getTopic();
  }
}
