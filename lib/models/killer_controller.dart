import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/modals/confirm_killer_modal.dart';
import 'package:intent_to_kill/modals/pick_killer_motivation.dart';
import 'package:intent_to_kill/screens/all_chars.dart';
import 'package:intent_to_kill/screens/pick_class.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class KillerController{
  KillerCharacter? _killerSetup;
  KillerCharacter? _figureSetup;
  KillerClass? _minionsClassSetup;
  KillerMotivation? _motivation;

  bool get allDone=> _killerSetup!=null && _figureSetup!=null && _minionsClassSetup!=null;


  KillerController();
  KillerController.fromJson(Map<String,dynamic> json){
    _killerSetup = parseEnum(KillerCharacter.values,json['killer']);
    _figureSetup = parseEnum(KillerCharacter.values,json['figure']);
    _minionsClassSetup = parseEnum(KillerClass.values, json['minionClass']);
    _motivation = parseEnum(KillerMotivation.values, json['motivation']);
  }

  update({KillerCharacter? killer,
  KillerCharacter? figure,
  KillerClass? minions}){
    _killerSetup=killer??_killerSetup;
    _figureSetup = figure??_figureSetup;
    _minionsClassSetup=minions??_minionsClassSetup;
  }

  clearKiller()=>_killerSetup=null;
  clearFigure()=>_figureSetup=null;
  clearMotive()=>_motivation=null;
  clearClass()=>_minionsClassSetup=null;
  updateNext(KillerCharacter character){
    if(_killerSetup==null){
      _killerSetup=character;
      return;
    }
    if(_figureSetup==null){
      _figureSetup=character;
      return;
    }
  }

  bool roleAvailable(KillerCharacter character)=>character!=_killerSetup && character!=_figureSetup;


  @override
  String toString() {
    return 'KillerController{_killerSetup: ${_killerSetup?.name.dpBlue()}, _figureSetup: ${_figureSetup?.name.dpBlue()}, _minionsClassSetup: ${_minionsClassSetup?.name.dpBlue()}, hash: ${hashCode.toString().dpGreen()}';
  }

  KillerCharacter get killer => _killerSetup!;
  KillerCharacter get figure => _figureSetup!;
  KillerClass get minionClass => _minionsClassSetup!;
  KillerMotivation get motivation => _motivation!;

  Map<String,dynamic> toJson() =>{
    'killer':killer.name,
    'figure':figure.name,
    'minionClass':minionClass.name,
    'motivation':motivation.name
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KillerController &&
          runtimeType == other.runtimeType &&
          _killerSetup == other._killerSetup &&
          _figureSetup == other._figureSetup &&
          _minionsClassSetup == other._minionsClassSetup;

  @override
  int get hashCode =>
      _killerSetup.hashCode ^
      _figureSetup.hashCode ^
      _minionsClassSetup.hashCode;

  Future<dynamic> getNextPage(BuildContext context, List<KillerMotivation> motivations)async{
    if(_killerSetup==null){
      'setup killer'.dpYellow().print();
      toString().print();
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PickKillers(title: getString().pick_killer, controller: this, key: Key(hashCode.toString()))));
    }
    if(_figureSetup==null){
      'setup figur'.dpYellow().print();
      toString().print();
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PickKillers(title: getString().pick_figurant, controller: this, key: Key(hashCode.toString()),)));
    }
    if(_motivation==null){
      'motivations; $motivations'.print();
      var result = await showAdminModal(PickKillerMotivationModal(motivations: motivations));
      if(result is KillerMotivation){
        _motivation = result;
      }else{
        _figureSetup = null;
        return getNextPage(context, motivations);
      }
    }
    if(_minionsClassSetup==null){
      'setup minion'.dpYellow().print();
      toString().print();
      var result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PickClass()));
      if(result is KillerClass){
          _minionsClassSetup=result;
      } else {
        return null;
      }
    }
    var confirm = await ConfirmKillerModal(this).show();
    if (confirm == true) {
      return this;
    }else{
      return getNextPage(context, motivations);
    }
  }

}