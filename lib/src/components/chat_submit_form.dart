import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/components/chat_submit_button.dart';

class ChatSubmitForm extends StatelessWidget {
  const ChatSubmitForm(
      {super.key, required this.inputController, required this.sendChat});

  final TextEditingController inputController;
  final void Function() sendChat;

  @override
  // メッセージ入力フォーム
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              maxLines: null, // 複数行表示
              controller: inputController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Theme.of(context).colorScheme.primary,
                filled: true,
                hintText: "メッセージを入力",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            )),
            ChatSubmitButton(sendChat: () {
              sendChat();
            }),
          ],
        ),
      ),
    );
  }
}
