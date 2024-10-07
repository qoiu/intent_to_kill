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

class PickGameModeModal extends StatefulWidget {
  const PickGameModeModal({super.key});

  @override
  State<PickGameModeModal> createState() => _PickGameModeModalState();
}

class _PickGameModeModalState extends State<PickGameModeModal> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      intrinsicWidth: true,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextBuilder(getString().pick_motivations).titleMedium().build(),
          const SizedBox(height: 20),
          MainButton(getString().mode_logic, ()=>Navigator.of(context).pop(GameMode.logic)),
          const SizedBox(height: 10),
          MainButton(getString().mode_intuition, ()=>Navigator.of(context).pop(GameMode.intuition))
        ],
      ),
    );
  }
}
