import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';

class ChatSubmitButton extends StatelessWidget {
  const ChatSubmitButton({super.key, required this.sendChat});

  final void Function() sendChat;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.send,
        color: ColorConstants.tqBlue,
      ),
      iconSize: 32,
      onPressed: () {
        sendChat();
      },
    );
  }
}
