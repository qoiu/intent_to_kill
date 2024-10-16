import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/killer_stats.dart';
import 'package:intent_to_kill/components/motivations.dart';
import 'package:intent_to_kill/components/update_inherited.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/shared_keys.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/screens/notepad.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class NotesScreen extends StatefulWidget {
  final NoteScreenController noteScreenController;

  const NotesScreen({super.key, required this.noteScreenController});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NoteScreenController controller;
  bool showInfo = false;
  GlobalKey bottomKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller = widget.noteScreenController;
  }


  @override
  Widget build(BuildContext context) {
    double heightBottomWidget = 60;
    double heightBottomWidgetBig = 200;
    'bottom height: ${bottomKey.size()?.height}'.print();
    var renderBox = bottomKey.currentContext?.findRenderObject() as RenderBox?;
    'bottom height: ${renderBox?.getMaxIntrinsicHeight(renderBox.debugAdoptSize(MediaQuery.of(context).size).height)}'
        .print();
    var potentialHeight = renderBox?.getMaxIntrinsicHeight(900000);
    return MainUpdateWidget(
      setState: setState,
      child: Column(
        children: [
          Flexible(child: Notepad(controller: controller)),
          const SizedBox(height: 10),
          MotivationsList(motivations: controller.motivations, onTap:  (motive) {
            controller.selectMotive(motive);
            setState(() {});
          }, isTrusted: (motive)=>controller.trustedMotive.contains(motive)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: KillerClass.values.map((e) => classItem(e)).toList(),
          ),
          GestureDetector(
              onTap: () {
                if(controller.killerController==null)return;
                setState(() {
                  controller.showBottomHint=false;
                  showInfo = !showInfo;
                });
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: showInfo
                      ? potentialHeight ?? heightBottomWidgetBig
                      : heightBottomWidget,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(controller.killerController == null
                            ? 'assets/images/detective.png'
                            : 'assets/images/knife.png'),
                      ),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(0, showInfo ? 0 : 1),
                        child: controller.killerController != null
                            ? KillerStats(
                                controller: controller.killerController!,
                                globalKey: bottomKey,
                              )
                            : Container(color: Colors.white),
                      ),
                      Center(
                        child: AnimatedOpacity(
                          opacity: controller.showBottomHint && controller.killerController!=null ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: AppCard(
                            color: getColorScheme().surface.withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextBuilder(controller.killerController == null
                                      ? getString().hint_detective
                                      : getString().hint_killer)
                                  .build()),
                        ),
                      )
                    ],
                  )))
        ],
      ),
    );
  }

  Widget classItem(KillerClass kClass) {
    var width = (MediaQuery.of(context).size.width - 50) / 9;
    var name = context.tr(kClass.name);
    return GestureDetector(
        onTap: () {
          if (controller.trusted.contains(kClass)) {
            controller.trusted.remove(kClass);
            'remove'.print();
          } else {
            controller.trusted.add(kClass);
            'add'.print();
          }
          controller.trusted.join(',').print();
          controller.saveGame();
          setState(() {});
        },
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset(kClass.image, width: width, fit: BoxFit.fitWidth),
              SizedBox(
                  width: width,
                  height: 30,
                  child: FittedBox(child: TextBuilder(name).build()))
            ]),
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(
                      controller.trusted.contains(kClass) ? 0.3 : 0),
                  border: Border.all(
                      color: Colors.green,
                      width: controller.trusted.contains(kClass) ? 2 : 0)),
            ),
          ],
        ));
  }
}

class NoteScreenController {
  NotepadController notepad = NotepadController();
  Set<KillerClass> trusted = {};
  Set<KillerMotivation> trustedMotive = {};
  bool showBottomHint = true;
  List<KillerMotivation> motivations=[];
  KillerController? killerController;

  NoteScreenController({this.killerController, required this.motivations});
  NoteScreenController.fromJson(Map<String,dynamic> json){
    notepad = NotepadController.fromJson(json['notepad']);
    trusted = Set.from(parseList(json['trusted'], (e)=>parseEnum(KillerClass.values, e.toString())));
    trustedMotive = Set.from(parseList(json['trustedMotive'], (e)=>parseEnum(KillerMotivation.values, e.toString())));
    showBottomHint=json['showBottomHint'];
    motivations = parseList(json['motivations'], (e)=>parseEnum(KillerMotivation.values, e.toString()));
  }

  selectMotive(KillerMotivation motive){
    if(trustedMotive.contains(motive)){
      trustedMotive.remove(motive);
    }else{
      trustedMotive.add(motive);
    }
    saveGame();
  }

  saveGame(){
    var json = jsonEncode(toJson());
    json.toString().dpBlue().print();
    AppSharedPreference.prefs.setString(SharedKeys.GAME_STATE.name, json);
  }

  Map<String,dynamic> toJson()=>{
    'notepad':notepad.toJson(),
    'trusted':trusted.map((e)=>e.name).toList(),
    'trustedMotive':trustedMotive.map((e)=>e.name).toList(),
    'showBottomHint':showBottomHint,
    'motivations':motivations.map((e)=>e.name).toList(),
    if(killerController!=null)'killer':killerController!.toJson()
  };
}
