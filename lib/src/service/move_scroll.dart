import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MoveScroll {
// ListViewを最下部まで自動スクロールする
  void last(ScrollController controller) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    });
  }
}