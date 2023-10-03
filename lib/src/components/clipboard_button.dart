import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';

class ClipboardButton extends StatelessWidget {
  const ClipboardButton({super.key, required this.responseMessage});

  final String responseMessage;

// AIメッセージをコピーするボタン
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.copy_outlined,
          size: 26,
        ),
        onPressed: () => {
              Clipboard.setData(ClipboardData(text: responseMessage)),
              context.showSnackBar(message: "コピーしました")
            });
  }
}
