import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/modals/pick_game_mode.dart';
import 'package:intent_to_kill/modals/pick_motivations.dart';
import 'package:intent_to_kill/modals/pick_role.dart';
import 'package:intent_to_kill/modals/pick_scenario.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/models/scenarios.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Opacity(
                opacity: 0.3,
                child:
                    Image.asset('assets/images/back.jpg', fit: BoxFit.cover))),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextBuilder(getString().app_name).titleLarge().build(),
              // MainButton(getString().start, ()=>Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const AllChars())))
              MainButton(getString().start, fill: false, () async {
                var role = await const PickRoleModal().show();
                if (role is! KillerRole) return;
                var gameMode =
                    await showAdminModal(const PickGameModeModal(), false);
                if (gameMode is! GameMode) return;
                var scenario = await showAdminModal(
                    PickScenarioModal(gameMode: gameMode), false);
                List<KillerMotivation> motivations = [];
                if (scenario is! Scenario) return;
                motivations = scenario.motivations;
                if (scenario is CustomScenario) {
                  var motivationModalResults = await showAdminModal(
                      PickMotivationsModal(required: gameMode==GameMode.logic?6:8));
                  if (motivationModalResults is! List<KillerMotivation>) {
                    return;
                  }
                  motivations = motivationModalResults;
                }
                'role; $role'.print();
                if(role==KillerRole.detective) {
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotesScreen(motivations: motivations)));
                }else{
                  KillerController controller = KillerController();
                  while (!controller.allDone) {
                    var result = await controller.getNextPage(context, motivations);
                    'role: $result'.print();
                    if (result == null) {
                      'Выбор не завершён'.print();
                      break;
                    }
                  }
                  if (controller.allDone) {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            NotesScreen(killerController: controller, motivations: motivations)));
                    'FINISH!'.dpGreen().print();
                  }
                }
              })
            ],
          ),
        ),
      ],
    );
  }
}
