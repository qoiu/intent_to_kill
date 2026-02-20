import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/components/screen_template.dart';
import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/enum/shared_keys.dart';
import 'package:intent_to_kill/main.dart';
import 'package:intent_to_kill/modals/pick_game_mode.dart';
import 'package:intent_to_kill/modals/pick_motivations.dart';
import 'package:intent_to_kill/modals/pick_role.dart';
import 'package:intent_to_kill/modals/pick_scenario.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/models/scenarios.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:intent_to_kill/screens/scenario_details.dart';
import 'package:intent_to_kill/screens/settings_screen.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  endGame() async {
    var gameNumber = AppSharedPreference.startGame();
    'gameNumber: $gameNumber'.print();
    if (gameNumber == 10) {
      if (await inAppReview.isAvailable()) {
        'appReview available'.dpRed().print();
        inAppReview.requestReview();
      } else {
        'appReview unavailable'.dpRed().print();
      }
    }
  }

  onStart(
      {KillerRole? role, GameMode? mode, Scenario? selectedScenario}) async {
    var startRole = role ?? await const PickRoleModal().show();
    if (startRole is! KillerRole) return;
    var gameMode =
        mode ?? await showAdminModal(const PickGameModeModal(), false);
    if (gameMode is! GameMode) {
      return onStart();
    }
    var scenario = selectedScenario ??
        await showAdminModal(PickScenarioModal(gameMode: gameMode), false);
    List<KillerMotivation> motivations = [];
    if (scenario is! Scenario) {
      return onStart(role: startRole);
    }
    motivations =
        scenario.motivations.take(gameMode == GameMode.logic ? 6 : 8).toList();
    if (scenario is CustomScenario) {
      var motivationModalResults = await showAdminModal(
          PickMotivationsModal(required: gameMode == GameMode.logic ? 6 : 8));
      if (motivationModalResults is! List<KillerMotivation>) {
        return;
      }
      motivations = motivationModalResults;
    } else {
      var confirmScenario = await Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (a, b, c) =>
              ScenarioDetails(scenario: scenario, mode: gameMode)));
      if (confirmScenario != true)
        return onStart(role: startRole, mode: gameMode);
    }
    ['motivartion'.dpRed(), motivations.toString()].print();
    '_role; $startRole'.print();
    if (startRole == KillerRole.detective) {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotesScreen(
              noteScreenController:
                  NoteScreenController(motivations: motivations))));
      endGame();
    } else {
      KillerController controller = KillerController();
      while (!controller.allDone) {
        var result = await controller.getNextPage(context, motivations);
        '_role: $result'.print();
        if (result == 'back') {
          return onStart(
              role: startRole, mode: gameMode, selectedScenario: scenario);
        }
        if (result == null) {
          'Выбор не завершён'.print();
          break;
        }
      }
      if (controller.allDone) {
        await nextScreen(NotesScreen(
            noteScreenController: NoteScreenController(
                killerController: controller, motivations: motivations)));
        // await Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => NotesScreen(
        //         noteScreenController: NoteScreenController(
        //             killerController: controller,
        //             motivations: motivations))));
        endGame();
        'FINISH!'.dpGreen().print();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      child: Stack(
        children: [
          SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Opacity(
                  opacity: 0.3,
                  child: Image.asset('assets/images/back.jpg',
                      fit: BoxFit.cover))),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextBuilder(getString().app_name).titleLarge().build(),
                // MainButton(getString().start, ()=>Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const AllChars())))
                Column(
                  children: [
                    MainButton(getString().start, fill: false, onStart),
                    if (AppSharedPreference.prefs
                            .getString(SharedKeys.GAME_STATE.name) !=
                        null) ...{
                      const SizedBox(height: 10),
                      MainButton(
                        getString().continue_btn,
                        () async {
                          var controllerJson = AppSharedPreference.prefs
                              .getString(SharedKeys.GAME_STATE.name);
                          ['load', controllerJson].print();
                          var controller = NoteScreenController.fromJson(
                              jsonDecode(controllerJson!));
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotesScreen(
                                  noteScreenController: controller)));
                        },
                        fill: false,
                      ),
                    },
                    const SizedBox(height: 12),
                    MainButton(fill: false, getString().settings, () async {
                      await nextScreen(const SettingsScreen());
                      setState(() {});
                    })
                  ],
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(10),
              child: TextBuilder('v 0.99.1')
                  .style(getTextStyle().bodySmall?.copyWith(fontSize: 8))
                  .build())
        ],
      ),
    );
  }
}
