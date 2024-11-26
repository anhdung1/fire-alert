import 'dart:ui';

import 'package:alert_app/blocs/chat_bloc.dart/chat_bloc.dart';
import 'package:alert_app/constant/colors_widget.dart';
import 'package:alert_app/constant/constant.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/repositories/chat_repository.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/chat_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
            ..add(ChatGetHistoryEvent(isCompleted: false))
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
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _contentController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  bool isLoadingMore = false;
  bool isCompleted = false;
  sendMessage() {
    context
        .read<ChatBloc>()
        .add(ChatSendMessageEvent(content: _contentController.text.trim()));
    _contentController.clear();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          !isCompleted) {
        isLoadingMore = true;
        context.read<ChatBloc>().add(ChatGetHistoryEvent(isCompleted: false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.black12),
          width: screenWidth,
          height: 50,
          child: Text(
            "Chung Cư 1A",
            style: TextStyle(fontSize: Constant.fontSizeTitle(screenHeight)),
          ),
        ),
        BlocConsumer<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatSuccessState ||
                state is ChatGetHistorySuccessState) {
              return chatSuccessState(state);
            }
            return const SizedBox();
          },
          listener: (context, state) {
            if (state is ChatGetHistorySuccessState) {
              isLoadingMore = false;
              if (state.isCompleted != null) {
                isCompleted = state.isCompleted!;
              }
            }
            if (state is ChatSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
            }
          },
        ),
        Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child:
                    inputText("Nhập tin nhắn ...", false, _contentController)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: InkWell(
                onTap: () {
                  sendMessage();
                },
                child: Icon(
                  Icons.send_rounded,
                  color: ColorsWidget.iconColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget chatSuccessState(state) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: ListView.builder(
          controller: _scrollController,
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
                              margin:
                                  const EdgeInsets.only(right: 10, left: 80),
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                  width: 34,
                                  height: 34,
                                  child: clipImage(
                                      state.listMessage[index].imageUrl)),
                            ),
                            Container(
                              alignment: const Alignment(0.5, -0.2),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
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
      ),
    );
  }

  clipImage(imageUrl) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/account.png"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
