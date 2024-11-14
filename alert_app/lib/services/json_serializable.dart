abstract class JsonSerializable {
  static JsonSerializable fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("fromJson() must be implemented.");
  }
}
