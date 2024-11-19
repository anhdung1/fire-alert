import 'package:alert_app/services/json_serializable.dart';

class ChatModel implements JsonSerializable {
  final String content;
  final String sendingTime;
  final int senderId;
  final String imageUrl;
  final String name;
  final bool isSentByCurrentUser;

  ChatModel(
      {required this.content,
      required this.sendingTime,
      required this.senderId,
      required this.isSentByCurrentUser,
      required this.imageUrl,
      required this.name});
  factory ChatModel.fromJson(Map<String, dynamic> json, int currentUserId) =>
      ChatModel(
          content: json["content"] ?? "",
          sendingTime: json["sendingTime"] ?? "",
          senderId: json["senderId"] ?? "",
          imageUrl: json["imageUrl"] ?? "",
          name: json["name"] ?? "",
          isSentByCurrentUser: (json["senderId"] ?? -1) == currentUserId);
}
