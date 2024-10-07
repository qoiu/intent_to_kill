import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/modals/confirm_modal.dart';
import 'package:intent_to_kill/modals/confirm_role_modal.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class PickKillers extends StatelessWidget {
  final String? title;
  final KillerController controller;

  const PickKillers({super.key, this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    var imgWidth = MediaQuery.of(context).size.width / 6;
    var list = KillerCharacter.values.toList();
    list.sort((a, b) => context
        .tr(a.name)
        .toLowerCase()
        .compareTo(context.tr(b.name).toLowerCase()));
    list.sort((a, b) =>
        a.kClass.name.toLowerCase().compareTo(b.kClass.name.toLowerCase()));
    return SingleChildScrollView(
      child: Column(
        children: [
          if (title != null) ...{
            const SizedBox(height: 10),
            Center(
              child: TextBuilder(title!).titleMedium().build(),
            ),
          },
          const SizedBox(height: 10),
          Wrap(
            children: list
                .map((character) => CharacterItem(
                    character: character,
                    imgWidth: imgWidth,
                    onTap: controller.roleAvailable(character)
                        ? () async {
                            var result = await ConfirmRoleModal(character)
                                .show();
                            if (result == true) {
                              controller.updateNext(character);
                              Navigator.of(context).pop(controller);
                            }
                          }
                        : null,
                    isGray: !controller.roleAvailable(character)))
                .toList(),
          ),
        ],
      ),
    );
  }
}
