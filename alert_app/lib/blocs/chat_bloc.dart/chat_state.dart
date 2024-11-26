part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatModel> listMessage;

  ChatSuccessState({required this.listMessage});
}

class ChatGetHistorySuccessState extends ChatState {
  bool? isCompleted;
  final List<ChatModel> listMessage;

  ChatGetHistorySuccessState({required this.listMessage, this.isCompleted});
}

class ChatGetHistoryFailure extends ChatState {}

class ChatConnectFailureState extends ChatState {}
