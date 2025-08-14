
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/qoiu_utills.dart';
import 'package:qoiu_utils/typedef.dart';

class WitnessStatement{
  KillerCharacter character;
  QuestionStatement sexMale = QuestionStatement('assets/icon/sex_m.png');
  QuestionStatement sexFemale = QuestionStatement('assets/icon/sex_f.png');
  QuestionStatement age20 = QuestionStatement('assets/icon/age_20.png');
  QuestionStatement age40 = QuestionStatement('assets/icon/age_40.png');
  QuestionStatement age60 = QuestionStatement('assets/icon/age_60.png');
  QuestionStatement sizeS = QuestionStatement('assets/icon/size_s.png');
  QuestionStatement sizeM = QuestionStatement('assets/icon/size_m.png');
  QuestionStatement sizeL = QuestionStatement('assets/icon/size_l.png');
  QuestionStatement heightS = QuestionStatement('assets/icon/height_s.png');
  QuestionStatement heightM = QuestionStatement('assets/icon/height_m.png');
  QuestionStatement heightL = QuestionStatement('assets/icon/height_l.png');
  List<WitnessComment> comments = [];


  WitnessStatement({required this.character});
  WitnessStatement.fromJson(Map<String,dynamic> json):character=parseEnum(KillerCharacter.values, json['character']){
    sexMale = QuestionStatement.fromJson(json['sexMale']);
    sexFemale = QuestionStatement.fromJson(json['sexFemale']);
    age20 = QuestionStatement.fromJson(json['age20']);
    age40 = QuestionStatement.fromJson(json['age40']);
    age60 = QuestionStatement.fromJson(json['age60']);
    sizeS = QuestionStatement.fromJson(json['sizeS']);
    sizeM = QuestionStatement.fromJson(json['sizeM']);
    sizeL = QuestionStatement.fromJson(json['sizeL']);
    heightS = QuestionStatement.fromJson(json['heightS']);
    heightM = QuestionStatement.fromJson(json['heightM']);
    heightL = QuestionStatement.fromJson(json['heightL']);
    comments = parseList(json['comments'], WitnessComment.fromJson);
  }

  Map<String,dynamic> toJson()=> {
    'character': character.name,
    'sexMale':sexMale.toJson(),
    'sexFemale':sexFemale.toJson(),
    'age20':age20.toJson(),
    'age40':age40.toJson(),
    'age60':age60.toJson(),
    'sizeS':sizeS.toJson(),
    'sizeM':sizeM.toJson(),
    'sizeL':sizeL.toJson(),
    'heightS':heightS.toJson(),
    'heightM':heightM.toJson(),
    'heightL':heightL.toJson(),
    'comments':comments.map((e)=>e.toJson()).toList()
  };
}

class QuestionStatement{
  String icon;
  KillerStatement answer = KillerStatement.empty;

  QuestionStatement(this.icon);

  QuestionStatement.fromJson(Map<String,dynamic> json):icon=json['icon']{
    answer = parseEnum(KillerStatement.values, json['answer']);
  }

  Map<String,dynamic> toJson() =>{
    'icon':icon,
    'answer':answer.name,
    'guess':[],
  };
}

enum KillerStatement{
  empty,yes,no;
}

// final icon = Icons.sentiment_dissatisfied
enum Guess{
  question(0xf0555),sure(0xe046),happy(0xf0152),norm(0xe578),bad(0xec6e);

  final int hash;

  const Guess(this.hash);
}

class WitnessComment{
  String comment='';
  String colorCode='';

  Color get color => colorCode.isEmpty?Colors.white:ColorExtension.fromCode(colorCode);

  WitnessComment();
  WitnessComment.fromJson(JsonMap map){
    comment = map['text'];
    colorCode = map['color'];
  }

  JsonMap toJson()=> {
    'text':comment,
    'color':colorCode
  };
}