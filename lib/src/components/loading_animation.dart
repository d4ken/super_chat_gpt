import 'package:flutter/material.dart';
import 'package:gpt_sdk_chatapp/src/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key, required this.widgetSize});

  final double widgetSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: ColorConstants.tqBlue,
        size: widgetSize,
      ),
    );
  }
}