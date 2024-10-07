import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';
import 'package:qoiu_utils/statefull_modal.dart';

import '../utils/themes.dart';

class PickKillerMotivationModal extends StatefulWidget {
  final List<KillerMotivation> motivations;
  const PickKillerMotivationModal({super.key, required this.motivations});

  @override
  State<PickKillerMotivationModal> createState() => _PickKillerMotivationModalState();
}

class _PickKillerMotivationModalState extends State<PickKillerMotivationModal> {
 KillerMotivation? selected;
  @override
  Widget build(BuildContext context) {
    var itemWidth = (MediaQuery.of(context).size.width - 100) / 3;
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 80),
      child: AppCard(
        intrinsicWidth: true,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextBuilder(getString().pick_killer_motivations).titleMedium().build(),
            const SizedBox(height: 20),
            Wrap(
              runSpacing: 10,
              children: KillerMotivation.values
                  .map((e) => GestureDetector(
                onTap: ()=>setState(() {
                  selected = e;
                }),
                    child: Container(
                          width: itemWidth,
                          decoration: BoxDecoration(
                            border: e==selected?Border.all(color: Colors.red, width: 3):null
                          ),
                          child: Column(
                            children: [
                              Image.asset(e.image(),
                                colorBlendMode: e!=selected ? BlendMode.saturation : null,
                                color: e!=selected ? AppTheme.grayFon3Color : null,),
                              TextBuilder(e.title(context)).maxLines(1).ellipsis().build(),
                            ],
                          ),
                        ),
                  ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            MainButton(getString().apply, ()=>Navigator.of(context).pop(selected), isActive: selected!=null)
          ],
        ),
      ),
    );
  }
}
