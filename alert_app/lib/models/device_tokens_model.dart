class DeviceTokensModel {
  final String deviceToken;
  final String deviceId;
  final String deviceName;

  DeviceTokensModel(
      {required this.deviceToken,
      required this.deviceId,
      required this.deviceName});
  Map<String, dynamic> toMap() {
    return {
      "deviceToken": deviceToken,
      "deviceId": deviceId,
      "deviceName": deviceName
    };
  }
}
