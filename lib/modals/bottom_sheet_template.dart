import 'package:qoiu_utils/navigation.dart';
import 'package:qoiu_utils/qoiu_utills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSheetTemplate extends StatelessWidget {
  final Widget child;
  final String? tag;
  final String title;
  final Widget? titleWidget;
  final Color? color;
  final EdgeInsets? padding;
  final bool simpleChild;

  const BottomSheetTemplate(this.child,
      {this.tag,
      this.color,
      this.title = "",
      this.simpleChild = false,
      this.padding,
      super.key})
      : titleWidget = null;

  const BottomSheetTemplate.widget(
      {super.key,
      required this.child,
      required this.tag,
      this.titleWidget,
      this.color,
      this.simpleChild = false,
      this.padding})
      : title = "";

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.vertical(top: Radius.circular(25));
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(rootNavigatorKey.currentContext!)
                .viewPadding
                .top),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: color ?? getColorScheme().surface),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom +
                  MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: titleWidget ??
                        Text(
                          title,
                          style: getTextStyle().titleMedium,
                        ),
                  )),
                  Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          if (tag == null) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).popUntil(
                                (route) => route.settings.name != tag);
                          }
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Icon(Icons.close, color: getColorScheme().onSurface)),
                        ),
                      ))
                ],
              ),
              Flexible(
                child: simpleChild
                    ? Padding(
                        padding: padding ?? const EdgeInsets.all(0),
                        child: child,
                      )
                    : IntrinsicHeight(
                        child: Padding(
                        padding: padding ??
                            const EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                        child: child,
                      )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
