class Constant {
  static String ip = "192.168.1.2";
  var json = {"fire": true, "ppm": "123.123", "temperature": "29.1"};
  String topic = "sensor/601/data";
  static double fontSizeTitle(double screenHeight) {
    return screenHeight / 30;
  }

  static double fontSizeContent(double screenWidth) {
    return screenWidth / 27;
  }
}
