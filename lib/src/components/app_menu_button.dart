import 'package:flutter/material.dart';

class AppMenuButton extends StatelessWidget {
  const AppMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){},
      icon: const Icon(Icons.menu),
      iconSize: 28,
    );
  }
}