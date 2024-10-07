import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/statefull_modal.dart';

class PickCharacterModal extends StatelessWidget {
  final KillerClass? killerClass;
  const PickCharacterModal({super.key,this.killerClass});

  @override
  Widget build(BuildContext context) {
    var list = KillerCharacter.values;
    if(killerClass!=null){
      list = list.where((e)=>e.kClass==killerClass).toList();
    }
    var itemWidth=(MediaQuery.of(context).size.width-100)/3;
    return SizedBox(
      width: MediaQuery.of(context).size.width-100,
      child: AppCard(
        intrinsicWidth: true,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextBuilder(getString().pick_role).titleMedium().build(),
            const SizedBox(height: 20),
            Wrap(
              children: list.map((e)=>CharacterItem(character: e, imgWidth: itemWidth, onTap: (){
                Navigator.of(context).pop(e);
              },)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
