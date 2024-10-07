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
import 'package:intent_to_kill/models/scenarios.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';
import 'package:qoiu_utils/statefull_modal.dart';

import '../utils/themes.dart';

class PickScenarioModal extends StatefulWidget {
  final GameMode gameMode;
  const PickScenarioModal({super.key, required this.gameMode});

  @override
  State<PickScenarioModal> createState() => _PickScenarioModalState();
}

class _PickScenarioModalState extends State<PickScenarioModal> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(10),
      intrinsicWidth: true,
      child: Column(
        children: [
          TextBuilder(getString().pick_scenario).titleMedium().build(),
          const SizedBox(height: 20),
          ...Scenario.scenarios(widget.gameMode).map((e) => Container(
              padding: const EdgeInsets.only(bottom: 10),
              child:
                  MainButton(e.title, () => Navigator.of(context).pop(e)))),
        ],
      ),
    );
  }
}
