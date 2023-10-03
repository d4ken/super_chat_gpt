import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/components/clipboard_button.dart';
import 'package:gpt_sdk_chatapp/src/components/fav_message_button.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';
import 'package:gpt_sdk_chatapp/src/models/chat.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {super.key, required this.scrollController, required this.conversations});

  final ScrollController scrollController;
  final List<Chat> conversations;

  @override
  // チャットリストビュー
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.toDouble();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: scrollController,
      padding: EdgeInsets.all(15),
      itemBuilder: (context, index) {
        var conversation = conversations[index];
        return Align(
          alignment: conversation.isMine
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 8,
                  left: conversation.isMine ? screenWidth * 0.23 : 0,
                  right: conversation.isMine ? 0 : screenWidth * 0.23,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: conversation.isMine
                      ? ColorConstants.tqBlue
                      : Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(conversation.text),
              ),
              if (!conversation.isMine)
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    // 回答をコピーするボタンを表示
                    ClipboardButton(
                      responseMessage: conversation.text,
                    ),
                    // お気に入りボタン
                    const FavMessageButton(),
                  ],
                )
            ],
          ),
        );
      },
      itemCount: conversations.length,
    );
  }
}
