import 'package:flutter/material.dart';

class PatchContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const PatchContainer(
      {this.child, this.padding = const EdgeInsets.all(10), this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/patch_2.png'),
                  fit: BoxFit.fill,
                  alignment: AlignmentGeometry.topCenter)),
          padding: padding,
          child: child),
    );
  }
}
