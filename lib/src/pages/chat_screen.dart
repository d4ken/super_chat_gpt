import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpt_sdk_chatapp/src/components/app_menu_button.dart';
import 'package:gpt_sdk_chatapp/src/components/chat_item.dart';
import 'package:gpt_sdk_chatapp/src/components/chat_submit_form.dart';
import 'package:gpt_sdk_chatapp/src/components/header_bar.dart';
import 'package:gpt_sdk_chatapp/src/components/loading_animation.dart';
import 'package:gpt_sdk_chatapp/src/models/chat.dart';
import 'package:gpt_sdk_chatapp/src/service/move_scroll.dart';
import 'dart:async';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late OpenAI openAI;
  final List<Chat> _conversations = [];
  final List<Messages> _messageHistory = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isResponseLoading = false;
  MoveScroll scroll = MoveScroll();

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: dotenv.get('OPENAI_API_KEY'),
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)));
    super.initState();
  }

  Future<void> send() async {
    String text = _controller.text.toString();

    if (text.trim().isEmpty) {
      return;
    }
    // 送信後にtextfield入力値を消す
    _controller.clear();

    setState(() {
      _conversations.add(Chat(text, true)); // じぶんが送る
      _messageHistory.add(Messages(role: Role.user, content: text));
      scroll.last(_scrollController);
      isResponseLoading = true;
    });
    final response = await openAI.onChatCompletion(
        request: ChatCompleteText(
            messages: _messageHistory,
            maxToken: 400,
            model: GptTurbo0631Model()));

    if (response != null && response.choices.isNotEmpty) {
      setState(() {
        String answer = response.choices.first.message!.content.trim();
        _conversations.add(Chat(answer, false)); // botが返す
        _messageHistory
            .add(Messages(role: Role.assistant, content: answer)); // マルチターン用
        scroll.last(_scrollController);
        isResponseLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(widget.title),
          actions: const [
            AppMenuButton(),
          ],
        ),
        body:
            // HeaderBar(),
            DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.grey[500],
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.question_answer,
                            color: ColorConstants.tqBlue,
                          ),
                        ),
                        const Tab(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [

                        Container(
                          child: const Center(
                            child: Text('1nd'),
                          ),
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: ChatItem(
                                  scrollController: _scrollController,
                                  conversations: _conversations),
                            ),
                            if (isResponseLoading) const LoadingAnimation(widgetSize: 38),
                            // ローディングアニメーション
                            ChatSubmitForm(inputController: _controller, sendChat: send)
                          ],
                        ),

                        Container(
                          child: const Center(
                            child: Text('3rd'),
                          ),
                        ),
                      ]),
                    )
                  ],
                ))
        // Column(
        //   children: [
        // Expanded(
        //   child: ChatItem(
        //       scrollController: _scrollController,
        //       conversations: _conversations),
        // ),
        // if (isResponseLoading) const LoadingAnimation(widgetSize: 38),
        // // ローディングアニメーション
        // ChatSubmitForm(inputController: _controller, sendChat: send)
        // ],
        // ),
        );
  }
}
