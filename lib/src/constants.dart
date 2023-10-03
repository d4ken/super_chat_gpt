import 'package:flutter/material.dart';

class ColorConstants {
  static Color tqBlue = const Color(0xff1a96d5);
  static Color tqBlack = const Color(0xff2f393f);

}

/// Snackbarを楽に表示させるための拡張メソッド
extension ShowSnackBar on BuildContext {
  /// 標準的なSnackbarを表示
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 1200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConstants.tqBlue,
      ));
  }

  /// エラーが起きた際のSnackbarを表示
  void showErrorSnackBar({required String message}) {
    showSnackBar(
      message: message,
      backgroundColor: Theme.of(this).colorScheme.error,
    );
  }
}
