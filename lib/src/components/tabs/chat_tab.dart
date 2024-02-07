import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../models/chat.dart';
import '../../service/move_scroll.dart';
import '../chat_item.dart';
import '../chat_submit_form.dart';
import '../loading_animation.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final TextEditingController _controller = TextEditingController();
  late OpenAI openAI;
  final List<Chat> _conversations = [];
  final List<Messages> _messageHistory = [];
  final ScrollController _scrollController = ScrollController();
  bool isResponseLoading = false;
  MoveScroll scroll = MoveScroll();

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: dotenv.get('OPENAI_API_KEY'),
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 20)));
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
            model: GptTurboChatModel()));

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
    return Column(
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
    );
  }
}