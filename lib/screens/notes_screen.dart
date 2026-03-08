import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/killer_stats.dart';
import 'package:intent_to_kill/components/motivations.dart';
import 'package:intent_to_kill/components/patch_container.dart';
import 'package:intent_to_kill/components/screen_template.dart';
import 'package:intent_to_kill/components/text_field.dart';
import 'package:intent_to_kill/components/update_inherited.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/shared_keys.dart';
import 'package:intent_to_kill/main.dart';
import 'package:intent_to_kill/modals/motivations_modal.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/screens/notepad.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/metrica.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

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
  GlobalKey bottomNoteKey = GlobalKey();
  bool editNote = false;
  TextEditingController commentController = TextEditingController();
  String lastNote = '';

  @override
  void initState() {
    commentController.text = widget.noteScreenController.comment;
    super.initState();
    controller = widget.noteScreenController;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      setState(() {});
    });
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
    var duration = const Duration(milliseconds: 300);
    return ScreenTemplate(
      child: Stack(
        children: [
          MainUpdateWidget(
            setState: setState,
            child: Column(
              children: [
                Flexible(
                    child: Notepad(
                  controller: controller,
                  parentState: this,
                )),
                MotivationsList(
                    motivations: controller.motivations,
                    onTap: (motive) {
                      controller.selectMotive(motive);
                      setState(() {});
                    },
                    isTrusted: (motive) =>
                        controller.trustedMotive.contains(motive)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      KillerClass.values.map((e) => classItem(e)).toList(),
                ),
                AnimatedContainer(
                    duration: duration,
                    height: controller.showNotes
                        ? bottomNoteKey.size()?.height ?? heightBottomWidgetBig
                        : showInfo
                            ? potentialHeight ?? heightBottomWidgetBig
                            : heightBottomWidget,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: heightBottomWidget,
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              showAdminModal(MotivationsModal(controller,
                                  onTap: (motive) {
                                    controller.selectMotive(motive);
                                    setState(() {});
                                  },
                                  isTrusted: (motive) => controller
                                      .trustedMotive
                                      .contains(motive)));
                            },
                            child: Material(
                              borderRadius: BorderRadiusGeometry.circular(10),
                              elevation: 4,
                              shadowColor: Colors.black,
                              color: AppTheme.white,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadiusGeometry.circular(10),
                                  child: Image.asset('assets/motive/back_${appLocale.value.languageCode}.jpg')),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 200, height: heightBottomWidget,
                          // color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              'GestureDetector tap'.print();
                              if (controller.killerController == null) return;
                              controller.showBottomHint = false;
                              showInfo = true;
                              setState(() {});
                            },
                            child: Container(
                              // color: Colors.red,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Image.asset(
                                  controller.killerController == null
                                      ? 'assets/images/detective.png'
                                      : 'assets/images/knife.png'),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          height: heightBottomWidget,
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              'tap'.print();
                              setState(() {
                                widget.noteScreenController.showNotes =
                                    !widget.noteScreenController.showNotes;
                                widget.noteScreenController.saveGame();
                              });
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(10),
                                child: Image.asset('assets/images/notes.png')),
                          ),
                        ),
                        IgnorePointer(
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: controller.showBottomHint &&
                                      controller.killerController != null
                                  ? 0.6
                                  : 0,
                              duration: duration,
                              child: PatchContainer(
                                  // canUseNewDesign: false,
                                  // color:
                                  //     getColorScheme().surface.withOpacity(0.5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: TextBuilder(
                                          controller.killerController == null
                                              ? getString().hint_detective
                                              : getString().hint_killer)
                                      .build()),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Container(
            alignment: AlignmentGeometry.bottomCenter,
            height: double.maxFinite,
            child: AnimatedSlide(
              duration: duration,
              offset: Offset(0, showInfo ? 0 : 1),
              child: controller.killerController != null
                  ? GestureDetector(
                      onTap: () => setState(() {
                        showInfo = false;
                      }),
                      child: KillerStats(
                        controller: controller.killerController!,
                        globalKey: bottomKey,
                      ),
                    )
                  : Container(color: Colors.white),
            ),
          ),
          Container(
            alignment: AlignmentGeometry.bottomCenter,
            child: AnimatedSlide(
                duration: duration,
                offset:
                    Offset(0, widget.noteScreenController.showNotes ? 0 : 1),
                child: GestureDetector(
                  onTap: widget.noteScreenController.showNotes && !editNote
                      ? () {
                          ['tap'].print();
                          if (widget.noteScreenController.showNotes) {
                            setState(() {
                              widget.noteScreenController.showNotes = false;
                            });
                          }
                        }
                      : null,
                  child: IntrinsicHeight(
                    child: Container(
                      key: bottomNoteKey,
                      padding: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          color: widget.noteScreenController.showNotes
                              ? Colors.transparent
                              : null,
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/notepad_bottom.png'),
                              fit: BoxFit.fitWidth,
                              alignment: AlignmentGeometry.topCenter)),
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: editNote
                                    ? CommonTextField(
                                        controller: commentController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        minLines: 1,
                                      )
                                    : TextBuilder(commentController.text)
                                        .style(AppSettings.commentCasualFont
                                            ? AppTheme.noteStyle
                                            : getTextStyle().bodyMedium)
                                        .build(),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                  onTap: () {
                                    if (editNote) {
                                      widget.noteScreenController.comment =
                                          commentController.text;
                                      if(commentController.text!=lastNote){
                                        ['update comment', '$lastNote => ${commentController.text}'].print();
                                        Metrica.sendEvent('Update main comment',
                                            {'comment':'$lastNote => ${commentController.text}'
                                        });
                                      }
                                    }else{
                                      lastNote = widget.noteScreenController.comment;
                                    }
                                    editNote = !editNote;
                                    widget.noteScreenController.saveGame();
                                    setState(() {});
                                  },
                                  child:
                                      Icon(editNote ? Icons.save : Icons.edit))
                            ],
                          )),
                    ),
                  ),
                )),
          ),
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
                  child: AutoSizeText(
                    name,
                    maxLines: 1,
                    maxFontSize: 10,
                    minFontSize: 3,
                    textAlign: TextAlign.center,
                  ))
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
  List<KillerMotivation> motivations = [];
  KillerController? killerController;
  bool showNotes = false;
  String comment = '';

  NoteScreenController({this.killerController, required this.motivations});

  NoteScreenController.fromJson(Map<String, dynamic> json) {
    ['parse json', json.toString().dpRed()].print();
    notepad = NotepadController.fromJson(json['notepad']);
    trusted = Set.from(appParseList(
        json['trusted'], (e) => parseEnum(KillerClass.values, e.toString())));
    trustedMotive = Set.from(appParseList(json['trustedMotive'],
        (e) => parseEnum(KillerMotivation.values, e.toString())));
    showBottomHint = false;
    comment = json['comment'] ?? '';
    showNotes = json['showNotes'] ?? false;
    killerController = json['killer'] == null
        ? null
        : KillerController.fromJson(json['killer']);
    motivations = appParseList(
        json['motivations'], (e) => parseEnum(KillerMotivation.values, e));
  }

  selectMotive(KillerMotivation motive) {
    if (trustedMotive.contains(motive)) {
      trustedMotive.remove(motive);
    } else {
      trustedMotive.add(motive);
    }
    saveGame();
  }

  saveGame() {
    var json = jsonEncode(toJson());
    ['saveGame', json].print();
    AppSharedPreference.prefs.setString(SharedKeys.GAME_STATE.name, json);
  }

  Map<String, dynamic> toJson() => {
        'notepad': notepad.toJson(),
        'trusted': trusted.map((e) => e.name).toList(),
        'trustedMotive': trustedMotive.map((e) => e.name).toList(),
        'showBottomHint': showBottomHint,
        'motivations': motivations.map((e) => e.name).toList(),
        'comment': comment,
        'showNotes': showNotes,
        if (killerController != null) 'killer': killerController!.toJson()
      };
}
