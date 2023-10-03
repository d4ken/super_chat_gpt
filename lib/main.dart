import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpt_sdk_chatapp/src/pages/chat_screen.dart';
import 'package:gpt_sdk_chatapp/src/theme/dark_theme.dart';
import 'package:gpt_sdk_chatapp/src/theme/light_theme.dart';

Future<void> main() async {
  const envFile = String.fromEnvironment('env');
  await dotenv.load(fileName: envFile);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat GPT SDK Chat App',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const ChatScreen(title: 'Super Chat GPT'));
  }
}
