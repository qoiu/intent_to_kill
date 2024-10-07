import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class ConfirmModal extends StatelessWidget {
  final String text;
  const ConfirmModal(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      intrinsicWidth: true,
      child: Column(
        children: [
          TextBuilder(text).labelMedium().build(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child: MainButton(getString().no, ()=>Navigator.of(context).pop(false), color: AppTheme.extraRedColor, fill: false,)),
              const SizedBox(width: 10),
              Flexible(child: MainButton(getString().yes, ()=>Navigator.of(context).pop(true), fill: false)),

          ],
          )
      ]
      ),
    );
  }
}
