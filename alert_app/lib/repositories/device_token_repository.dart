import 'package:alert_app/services/device_token_service.dart';
import 'package:alert_app/services/result.dart';

class DeviceTokenRepository {
  final DeviceTokenService deviceTokenService;
  DeviceTokenRepository({required this.deviceTokenService});
  Future<Result<String>> sendDeviceInfo() {
    return deviceTokenService.sendInfoDevice();
  }

  Future<void> deleteDeviceToken() async {
    await deviceTokenService.deleteDeviceToken();
  }
}
