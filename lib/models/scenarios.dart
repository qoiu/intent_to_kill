import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/utils/utils.dart';

abstract class Scenario {
  abstract String title;
  abstract List<KillerMotivation> motivations;

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
  List<KillerMotivation> motivations = [];

  @override
  String title = getString().scenario_custom;
}

class AgentsScenario extends Scenario {
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
