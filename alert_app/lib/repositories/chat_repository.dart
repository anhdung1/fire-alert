import 'package:alert_app/models/chat_model.dart';
import 'package:alert_app/services/chat_service.dart';
import 'package:alert_app/services/result.dart';

class ChatRepository {
  final ChatService chatService;
  ChatRepository({required this.chatService});
  Future<Result<List<ChatModel>>> getMessageHistory(int page) async {
    return await chatService.getChatHistory(page);
  }

  Future<void> connectToWebSocket() async {
    await chatService.connect();
  }

  bool isActive() {
    return chatService.isActive();
  }

  Future<void> sendMessage(String content) async {
    await chatService.sendMessage(content);
  }

  void setOnMessageReceived(Function(ChatModel)? onMessageReceived) {
    chatService.onMessageReveived = onMessageReceived;
  }

  void disconnect() {
    chatService.disconnect();
  }
}
