import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/components/app_menu_button.dart';
import 'package:gpt_sdk_chatapp/src/components/tabs/chat_tab.dart';
import 'package:gpt_sdk_chatapp/src/components/tabs/fav_tab.dart';
import 'package:gpt_sdk_chatapp/src/components/tabs/setting_tab.dart';
import '../constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(title),
          actions: const [
            AppMenuButton(),
          ],
        ),
        body: DefaultTabController(
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
                    const SettingTab(),
                    ChatTab(),
                    const FavTab(),
                  ]),
                )
              ],
            )));
  }
}
