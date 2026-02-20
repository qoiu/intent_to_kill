import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/characters.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';

class ConfirmRoleModal extends StatelessWidget {
  final KillerCharacter character;

  const ConfirmRoleModal(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(children: [
        const SizedBox(height: 20),
        // TextBuilder(getString().pick_role_confirm(context.tr(character.name)))
        //     .labelMedium()
        //     .build(),
        // const SizedBox(height: 20),
        CharacterItem(character: character, imgWidth: 200, showStats: true),
        Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 20), child: CharacterStats(character)),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if(AppSettings.useNewStyle)...{
              const Spacer()
            },
            MainButton(getString().no, () => Navigator.of(context).pop(false),
                color: AppTheme.extraRedColor, fill: false,),
            const SizedBox(width: 10),
            MainButton(getString().yes, () => Navigator.of(context).pop(true), fill: false,),
          ],
        )
      ]),
    );
  }
}
