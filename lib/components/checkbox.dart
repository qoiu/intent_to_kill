import 'package:flutter/material.dart';
import 'package:qoiu_utils/qoiu_utils.dart';
class RadioButton extends StatelessWidget {
  final bool isCircle;
  final bool isSelected;
  final Function(bool)? onClick;
  final Color? color;
  final Color? inactiveColor;
  final double size;

  const RadioButton(
    this.isSelected, {
    super.key,
    this.onClick,
    this.isCircle = true,
    this.color,
    this.inactiveColor,
    this.size = 24,
  });

  const RadioButton.checkbox(
    this.isSelected, {
    super.key,
    this.onClick,
    this.color,
        this.inactiveColor,
    this.size = 24,
  }):isCircle = false;

  @override
  Widget build(BuildContext context) {
    var borderRadius = isCircle
        ? BorderRadius.circular(25)
        : BorderRadius.circular(6);
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: isCircle?Border.all(color: getColorScheme().primary, width: 1.8):null,
          borderRadius: borderRadius,
          // color: inactiveColor
        ),
        child: Material(
          borderRadius: borderRadius,
          color: inactiveColor??getColorScheme().onInverseSurface,
          child: InkWell(
            onTap: onClick!=null?()=>onClick!(!isSelected):null,
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color ?? getColorScheme().primary,
                ),
                child: Image.asset('assets/icon/yes.png', width: 12, height: 12)
                // Icon(
                //   Icons.check,
                //   color: getColorScheme().surface,
                //   size: size - 12,
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadioButtonWithText extends StatelessWidget {
  final String title;
  final String? description;
  final bool isSelected;
  final bool isCircle;
  final Widget? child;
  final Function(bool)? onClick;
  final EdgeInsets padding;
  final Color? color;

  const RadioButtonWithText({
    required this.isSelected,
    required this.title,
    this.onClick,
    this.color,
    this.description,
    this.isCircle = true,
    this.padding  = const EdgeInsets.all(10),
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onClick != null
          ? () {
              onClick!(!isSelected);
            }:null,
      child: Padding(
        padding: padding,
        child: buildRow(child),
      ),
    );
  }

  Row buildRow([Widget? child]) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        RadioButton(
          isSelected,
          isCircle: isCircle,
          onClick: onClick,
          color: color,
        ),
        const SizedBox(width: 5),
        Expanded(
          child:
              child ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: getTextStyle().bodyMedium),
                  if (description != null) ...[
                    Text(description!, style: getTextStyle().bodyMedium?.copyWith(color: getColorScheme().outline)),
                  ],
                ],
              ),
        ),
      ],
    );
  }
}

class CheckBoxWithText extends StatelessWidget {
  final String title;
  final String? description;
  final bool isSelected;
  final bool isCircle;
  final Widget? child;
  final Function(bool)? onClick;
  final EdgeInsets padding;
  final Color? color;

  const CheckBoxWithText({
    required this.isSelected,
    required this.title,
    this.onClick,
    this.description,
    this.isCircle = false,
    this.padding  = const EdgeInsets.all(10),
    this.child,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioButtonWithText(
      isSelected: isSelected,
      title: title,
      description: description,
      onClick: onClick,
      isCircle: isCircle,
      padding: padding,
      color: color,
      child: child,
    );
  }
}
