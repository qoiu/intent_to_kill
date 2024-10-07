import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class PickRoleModal extends StatelessWidget {
  const PickRoleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextBuilder(getString().pick_role).build(),
          const SizedBox(height:20),
          MainButton(getString().detective, ()=>Navigator.of(context).pop(KillerRole.detective), fill: true),
          const SizedBox(height: 10),
          MainButton(getString().killer, ()=>Navigator.of(context).pop(KillerRole.killer), fill: true),
        ],
      ),
    );
  }
}
