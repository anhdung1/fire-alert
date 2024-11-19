import 'dart:async';

import 'package:alert_app/models/chat_model.dart';
import 'package:alert_app/repositories/chat_repository.dart';
import 'package:alert_app/services/result.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  int page = 0;
  final ChatRepository chatRepository;
  final List<ChatModel> listMessage = [];
  ChatBloc(this.chatRepository) : super(ChatInitialState()) {
    on<ChatGetHistoryEvent>(_getHistory);
    on<ChatConnectWebsocketEvent>(_connect);
    on<ChatSendMessageEvent>(_sendMessage);
    on<ChatReceivedMessage>(_receivedMessage);
  }

  FutureOr<void> _getHistory(
      ChatGetHistoryEvent event, Emitter<ChatState> emit) async {
    Result<List<ChatModel>> result =
        await chatRepository.getMessageHistory(page);

    if (result.isSuccess) {
      page++;
      listMessage.insertAll(0, result.data!);
      emit(ChatSuccessState(listMessage: listMessage));
    }
  }

  FutureOr<void> _receivedMessage(
      ChatReceivedMessage event, Emitter<ChatState> emit) {
    emit(ChatSuccessState(listMessage: listMessage));
  }

  FutureOr<void> _connect(
      ChatConnectWebsocketEvent event, Emitter<ChatState> emit) async {
    await chatRepository.connectToWebSocket();
    if (chatRepository.isActive()) {
      chatRepository.setOnMessageReceived((message) {
        listMessage.insert(0, message);
        add(ChatReceivedMessage(listMessage: listMessage));
      });
    }
    emit(ChatSuccessState(listMessage: listMessage));
  }

  FutureOr<void> _sendMessage(
      ChatSendMessageEvent event, Emitter<ChatState> emit) async {
    if (chatRepository.isActive()) {
      await chatRepository.sendMessage(event.content);
    }
  }

  @override
  Future<void> close() {
    chatRepository.disconnect();
    return super.close();
  }
}
