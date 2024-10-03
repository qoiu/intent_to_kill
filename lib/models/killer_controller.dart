import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/screens/all_chars.dart';
import 'package:intent_to_kill/screens/pick_class.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class KillerController{
  KillerCharacter? _killerSetup;
  KillerCharacter? _figureSetup;
  KillerClass? _minionsClassSetup;

  bool get allDone=> _killerSetup!=null && _figureSetup!=null && _minionsClassSetup!=null;

  update({KillerCharacter? killer,
  KillerCharacter? figure,
  KillerClass? minions}){
    _killerSetup=killer??_killerSetup;
    _figureSetup = figure??_figureSetup;
    _minionsClassSetup=minions??_minionsClassSetup;
  }

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

  Future<dynamic> getNextPage(context)async{
    if(_killerSetup==null){
      'setup killer'.dpYellow().print();
      toString().print();
      return await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PickKillers(title: getString().pick_killer, controller: this, key: Key(hashCode.toString()))));
    }
    if(_figureSetup==null){
      'setup figur'.dpYellow().print();
      toString().print();
      return await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PickKillers(title: getString().pick_figurant, controller: this, key: Key(hashCode.toString()),)));
    }
    if(_minionsClassSetup==null){
      'setup minion'.dpYellow().print();
      toString().print();
      var result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PickClass()));
      if(result is KillerClass){
        _minionsClassSetup=result;
        return this;
      } else {
        return null;
      }
    }
    return this;
  }
}