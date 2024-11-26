part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatGetHistoryEvent extends ChatEvent {
  final bool isCompleted;

  ChatGetHistoryEvent({required this.isCompleted});
}

class ChatConnectWebsocketEvent extends ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  final String content;

  ChatSendMessageEvent({required this.content});
}

class ChatReceivedMessage extends ChatEvent {
  final List<ChatModel> listMessage;

  ChatReceivedMessage({required this.listMessage});
}
