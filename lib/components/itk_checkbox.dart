import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/patch_container.dart';

class ITKCheckbox extends StatelessWidget {
  final String text;
  final bool state;
  final VoidCallback onChange;
  final EdgeInsets padding;
  const ITKCheckbox({required this.text, required this.state, required this.onChange, this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 10), super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: PatchContainer(
        padding: padding,
        child: Row(
          children: [
            Expanded(child: Text(text)),
            Image.asset(state?'assets/icon/yes.png':'assets/icon/no.png', width: 40, height: 40)
          ],
        ),
      ),
    );
  }
}
