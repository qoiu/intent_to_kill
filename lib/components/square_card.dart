import 'package:flutter/material.dart';

class SquareCard extends StatelessWidget {
  final Widget child;
  final double size;
  final EdgeInsets padding;
  const SquareCard({this.size =200, required this.child, this.padding = const EdgeInsets.all(10), super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: padding,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/notepad_mid.png'),
              fit: BoxFit.cover,
              alignment: AlignmentGeometry.topCenter)),
      child: child,
    );
  }
}
