import 'package:alert_app/blocs/chat_bloc.dart/chat_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/repositories/chat_repository.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) =>
                ChatService(apiService: context.read<ApiService>()),
          ),
          RepositoryProvider(
            create: (context) =>
                ChatRepository(chatService: context.read<ChatService>()),
          )
        ],
        child: BlocProvider(
          create: (context) => ChatBloc(context.read<ChatRepository>())
            ..add(ChatGetHistoryEvent())
            ..add(ChatConnectWebsocketEvent()),
          child: const ChatScreen(),
        ));
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _contentController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  sendMessage() {
    context
        .read<ChatBloc>()
        .add(ChatSendMessageEvent(content: _contentController.text.trim()));
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Text(
            "Message",
            style: TextStyle(fontSize: Constant.fontSizeTitle(screenHeight)),
          ),
          BlocConsumer<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatSuccessState) {
                return chatSuccessState(state);
              }
              return const SizedBox();
            },
            listener: (context, state) {},
          ),
          Row(
            children: [
              Expanded(
                  child: inputText(
                      "Nhập tin nhắn ...", false, _contentController)),
              InkWell(
                onTap: () {
                  sendMessage();
                },
                child: Icon(
                  Icons.send_rounded,
                  color: ColorsWidget.iconColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget chatSuccessState(ChatSuccessState state) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: state.listMessage.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: state.listMessage[index].isSentByCurrentUser
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, left: 80),
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 0, 209, 192),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              state.listMessage[index].content,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                                width: 34,
                                height: 34,
                                child: clipImage(
                                    state.listMessage[index].imageUrl)),
                          ),
                          Container(
                            alignment: const Alignment(0.5, -0.2),
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            height: 34,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              state.listMessage[index].content,
                            ),
                          )
                        ],
                      ),
                    ));
        },
      ),
    );
  }

  clipImage(imageUrl) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          imageUrl,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/account.png",
              // width: 60,
              errorBuilder: (context, error, stackTrace) {
                return const Text("error");
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
