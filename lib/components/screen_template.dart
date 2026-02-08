import 'package:flutter/material.dart';
import 'package:intent_to_kill/main.dart';


class ScreenTemplate extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Size? fixedImage;
  final bool showBackground;

  const ScreenTemplate(
      {required this.child,
      this.fixedImage,
      this.padding = EdgeInsets.zero,
      this.showBackground = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(children: [
        if (showBackground) ...{StableBackground()},
        SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: padding,
              child: child,
            ),
          ),
        )
      ]),
    );
  }
}
