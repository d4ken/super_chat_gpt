import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                    child: Text('1st'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('2nd'),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Text('3rd'),
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
