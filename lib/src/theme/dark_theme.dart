import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: ColorConstants.tqBlack,
    secondary: Colors.grey[800]!,
  ),
);
