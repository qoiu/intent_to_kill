import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/statefull_modal.dart';

class PickRoleModal extends StatelessWidget {
  const PickRoleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          TextBuilder(getString().pick_role).build(),
          const SizedBox(height: 40),
          MainButton(getString().detective, ()=>Navigator.of(context).pop(KillerRole.detective)),
          const SizedBox(height: 10),
          MainButton(getString().killer, ()=>Navigator.of(context).pop(KillerRole.killer)),
        ],
      ),
    );
  }
}
