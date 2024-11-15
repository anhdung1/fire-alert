abstract class JsonSerializable {
  static JsonSerializable fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("fromMap() must be implemented.");
  }
}
