
import 'package:flutter/material.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool intrinsicHeight;
  final bool intrinsicWidth;

  const AppCard({this.child, this.padding, this.onTap, this.intrinsicHeight=true, this.intrinsicWidth=true, super.key});

  Widget intrinsic({required Widget child})=>intrWidth(child: intrinsicHeight?IntrinsicHeight(child: child):child);
  Widget intrWidth({required Widget child})=>intrinsicWidth?IntrinsicWidth(child: child):child;
  @override
  Widget build(BuildContext context) {
    var borderRadius=const BorderRadius.all(Radius.circular(20));
    return intrinsic(
      child: Material(
        borderRadius: borderRadius,
        color: getColorScheme().surface,
        shadowColor: Colors.black.withAlpha(64),
        elevation: 4,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: child,
          ),
        ),
      ),
    );
  }
}
