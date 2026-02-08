import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class AppCardSimple extends StatefulWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool intrinsicHeight;
  final bool intrinsicWidth;
  final Color? color;

  const AppCardSimple(
      {this.child,
      this.padding,
      this.onTap,
      this.intrinsicHeight = true,
      this.intrinsicWidth = true,
      this.color,
      super.key});

  @override
  State<AppCardSimple> createState() => _AppCardSimpleState();
}

class _AppCardSimpleState extends State<AppCardSimple> {

  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      for (var i = 0; i < 10; ++i) {
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() {});
      }
    });
  }

  Widget intrinsic({required Widget child}) =>
      intrWidth(child: widget.intrinsicHeight ? IntrinsicHeight(child: child) : child);

  Widget intrWidth({required Widget child}) =>
      widget.intrinsicWidth ? IntrinsicWidth(child: child) : child;

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(20));
    return intrinsic(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
                borderRadius: borderRadius,
                color: widget.color ?? getColorScheme().surface,
                shadowColor: Colors.black.withAlpha(64),
                elevation: 4,
                child: Container(decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage('assets/images/notepad_background.jpg'),
                        fit: BoxFit.contain,
                        opacity: AppSettings.newDesignOpacity,
                        alignment: AlignmentGeometry.topCenter)),child: buildChild(borderRadius)),
              ),
      ),
    );
  }

  InkWell buildChild(BorderRadius borderRadius) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: widget.onTap,
      child: Container(
        padding:
            widget.padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: widget.child,
      ),
    );
  }

  Widget buildNewStyle(Widget child) {
    double ratio = 0;
    double? maxSize ;
    globalKey.size()?.let((size) {
       ratio = size.width / size.height;
       maxSize = max(size.width, size.height);
    });
    bool rect = ratio > 0.8 && ratio < 1.2;
    ['ratio',ratio].print();
    return Container(
      width: maxSize,
      height: maxSize,
      key: globalKey,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ratio<=0.8?'assets/images/notepad_height.png':ratio>=1.2?'assets/images/notepad_width.png':'assets/images/notepad_mid.png'),
              fit: BoxFit.fill,
              alignment: AlignmentGeometry.topCenter)),
      child:
      // ratio > 0.8 && ratio < 1.2
      //     ? AspectRatio(
      //         aspectRatio: 1,
      //         child: child,
      //       )
      //     :
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: child,
      ),
    );
  }
}
