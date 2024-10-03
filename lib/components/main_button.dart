import 'package:flutter/material.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class MainButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final bool isLoading;
  final bool isActive;
  final Color? color;
  final Widget? extraRight;
  final Widget? child;
  final Color? border;
  final bool filled;
  final bool uppercase;
  final bool fill;

  const MainButton(this.text, this.onClick,
      {this.isLoading = false,
      this.isActive = true,
      this.color,
      this.border,
      this.child,
        this.fill=false,
        this.uppercase=true,
        this.extraRight,
        this.filled = true,
      super.key});

  @override
  Widget build(BuildContext context) {

    return fill?buildMaterial(context):IntrinsicWidth(child: buildMaterial(context));
  }

  Material buildMaterial(BuildContext context) {
    return Material(
    color:
        (color ?? getColorScheme(context).primary).withOpacity(isActive ? 1.0 : 0.5),
    borderRadius: BorderRadius.circular(5),
    elevation:isActive?3:0,
    child: InkWell(
      highlightColor: Colors.white.withAlpha(30),
      onTap: isActive && !isLoading
          ? () {
              onClick();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        constraints: const BoxConstraints(minHeight: 30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(filled)...{const Expanded(
                child: SizedBox(
                  height: 0,
                ))},
            Stack(
              alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: isLoading?0:1,
                      child: child??Text(
                          uppercase?text.toUpperCase():text,
                          maxLines: 2,
                          style: getTextStyle().bodyMedium?.copyWith(color: getColorScheme(context).onPrimary, letterSpacing: 1, fontSize: 14),
                        ),
                    ),
                    isLoading
                        ?Center(child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: getColorScheme(context).surface,
                      ))):Container()
                  ],
                ),
            if(extraRight!=null)...{
              const SizedBox(width: 10,),
              extraRight!
            },
            if(filled)...{const Expanded(
                child: SizedBox(
                  height: 0,
                ))},
          ],
        ),
      ),
    ),
  );
  }
}
