import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/utils/utils.dart';

abstract class Scenario {
  abstract String title;
  abstract String description;
  abstract String image;
  abstract List<KillerMotivation> motivations;
  String? agent;

  static final List<Scenario> _scenarios = [
    BaseScenario(),
    CustomScenario(),
    AgentsScenario(),
    DangerLandScenario(),
    EvilScenario(),
    DeadScenario(),
    PanicScenario(),
    StreetScenario(),
    StrangerScenario(),
    LastSecondScenario()
  ];

  static List<Scenario> scenarios(GameMode gameMode){
    if(gameMode==GameMode.intuition){
      return _scenarios.where((e)=>e is! BaseScenario).toList();
    }
    return _scenarios;
  }
}

class BaseScenario extends Scenario {
  @override
  String image = 'assets/scenario/base.jpg';
  @override
  String description = 'scenario_base';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.maniac,
    KillerMotivation.sadist,
    KillerMotivation.thug,
    KillerMotivation.vigilant,
    KillerMotivation.killer,
    KillerMotivation.terrorist
  ];

  @override
  String title = getString().scenario_base;
}

class CustomScenario extends Scenario {
  @override
  String image = '';
  @override
  String description = '';
  @override
  List<KillerMotivation> motivations = [];

  @override
  String title = getString().scenario_custom;
}

class AgentsScenario extends Scenario {
  @override
  String image = 'assets/scenario/agent.png';
  @override
  String description = 'scenario_agent';
  @override
  String get agent => 'agnt';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.spy,
    KillerMotivation.thug,
    KillerMotivation.psychopath,
    KillerMotivation.vigilant,
    KillerMotivation.terrorist,
    KillerMotivation.sadist,
    KillerMotivation.maniac,
    KillerMotivation.robber
  ];

  @override
  String title = getString().scenario_agents;
}

class DangerLandScenario extends Scenario {
  @override
  String image = 'assets/scenario/lands.png';
  @override
  String description = 'scenario_land';
  @override
  String get agent => 'ptrl';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.killer,
    KillerMotivation.psychopath,
    KillerMotivation.vigilant,
    KillerMotivation.cultist,
    KillerMotivation.sadist,
    KillerMotivation.maniac,
    KillerMotivation.spy,
    KillerMotivation.robber
  ];

  @override
  String title = getString().scenario_lands;
}


class EvilScenario extends Scenario {
  @override
  String image = 'assets/scenario/evil.png';
  @override
  String description = 'scenario_evil';
  @override
  String get agent => 'prosec';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.spy,
    KillerMotivation.sadist,
    KillerMotivation.thug,
    KillerMotivation.maniac,
    KillerMotivation.radical,
    KillerMotivation.psychopath,
    KillerMotivation.terrorist,
    KillerMotivation.vigilant
  ];

  @override
  String title = getString().scenario_evil;
}

class DeadScenario extends Scenario {
  @override
  String image = 'assets/scenario/dead.png';
  @override
  String description = 'scenario_dead';
  @override
  String get agent => 'fila';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.spy,
    KillerMotivation.sadist,
    KillerMotivation.radical,
    KillerMotivation.maniac,
    KillerMotivation.cannibal,
    KillerMotivation.robber,
    KillerMotivation.killer,
    KillerMotivation.vigilant
  ];

  @override
  String title = getString().scenario_dead;
}

class PanicScenario extends Scenario {
  @override
  String image = 'assets/scenario/panic.png';
  @override
  String description = 'scenario_panic';
  @override
  String get agent => 'surg';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.robber,
    KillerMotivation.spy,
    KillerMotivation.psychopath,
    KillerMotivation.sadist,
    KillerMotivation.vigilant,
    KillerMotivation.cultist,
    KillerMotivation.radical,
    KillerMotivation.thug
  ];

  @override
  String title = getString().scenario_panic;
}

class StreetScenario extends Scenario {
  @override
  String image = 'assets/scenario/street.png';
  @override
  String description = 'scenario_street';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.sadist,
    KillerMotivation.spy,
    KillerMotivation.vigilant,
    KillerMotivation.robber,
    KillerMotivation.maniac,
    KillerMotivation.terrorist,
    KillerMotivation.thug,
    KillerMotivation.cultist
  ];

  @override
  String title = getString().scenario_street;
}

class StrangerScenario extends Scenario {
  @override
  String image = 'assets/scenario/stranger.png';
  @override
  String description = 'scenario_stranger';
  @override
  String get agent => 'weld';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.killer,
    KillerMotivation.robber,
    KillerMotivation.radical,
    KillerMotivation.vigilant,
    KillerMotivation.terrorist,
    KillerMotivation.maniac,
    KillerMotivation.sadist,
    KillerMotivation.spy
  ];

  @override
  String title = getString().scenario_stranger;
}

class LastSecondScenario extends Scenario {
  @override
  String image = 'assets/scenario/last_second.png';
  @override
  String description = 'scenario_last_second';
  @override
  String get agent => 'vet';
  @override
  List<KillerMotivation> motivations = [
    KillerMotivation.thug,
    KillerMotivation.cannibal,
    KillerMotivation.terrorist,
    KillerMotivation.maniac,
    KillerMotivation.sadist,
    KillerMotivation.killer,
    KillerMotivation.robber,
    KillerMotivation.vigilant
  ];

  @override
  String title = getString().scenario_last_sec;
}
