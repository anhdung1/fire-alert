import 'dart:convert';
import 'dart:developer';

import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/local/preference_helper.dart';
import 'package:alert_app/models/chat_model.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/http_error.dart';
import 'package:alert_app/services/result.dart';
import 'package:http/http.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatService {
  late StompClient stompClient;
  final ApiService apiService;
  Function(ChatModel)? onMessageReveived;

  ChatService({required this.apiService});
  Future<Result<List<ChatModel>>> getChatHistory(int page) async {
    List<ChatModel> listChat = [];
    try {
      Response response = await apiService.getMapping("chat-history");
      if (response.statusCode == 200) {
        List result = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < result.length; i++) {
          ChatModel chat = ChatModel.fromJson(result[i] as Map<String, dynamic>,
              await PreferenceHelper.getUserId());
          listChat.add(chat);
        }

        return Result(data: listChat);
      } else {
        return Result(
            error: "error: ${HttpError.getErrorMessage(response.statusCode)}");
      }
    } catch (e) {
      return Result(error: e.toString());
    }
  }

  Future<void> connect() async {
    String apiKey = await PreferenceHelper.getApiKey();
    stompClient = StompClient(
        config: StompConfig.sockJS(
            url: "http://${Constant.ip}:8080/websocket",
            webSocketConnectHeaders: <String, String>{"x-api-key": apiKey},
            onConnect: (StompFrame frame) => _onConnect(frame),
            onWebSocketError: (dynamic error) => log(
                  'WebSocket error : $error',
                )));
    stompClient.activate();
  }

  Future<void> _onConnect(StompFrame frame) async {
    int userId = await PreferenceHelper.getUserId();
    stompClient.subscribe(
        destination: '/topic',
        callback: (StompFrame frame) async {
          if (onMessageReveived != null) {
            onMessageReveived!(ChatModel.fromJson(
                jsonDecode(frame.body ?? "") as Map<String, dynamic>, userId));
          }
        });
    log("Connected success");
  }

  Future<void> sendMessage(String content) async {
    try {
      stompClient.send(destination: '/app/chat.sendMessage', body: '''
    {
    "content":"$content"
    }
''', headers: <String, String>{
        "x-api-key": await PreferenceHelper.getApiKey()
      });
    } catch (e) {
      log(e.toString());
    }
  }

  bool isActive() {
    return stompClient.isActive;
  }

  void disconnect() {
    stompClient.deactivate();
    log("Disconnected from WebSocket");
  }
}
