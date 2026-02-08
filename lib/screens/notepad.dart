import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/patch_container.dart';
import 'package:intent_to_kill/components/popup_menu.dart';
import 'package:intent_to_kill/components/square_card.dart';
import 'package:intent_to_kill/components/update_inherited.dart';
import 'package:intent_to_kill/enum/characters.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/modals/edit_question_statement.dart';
import 'package:intent_to_kill/modals/pick_character.dart';
import 'package:intent_to_kill/modals/witness_comment_modal.dart';
import 'package:intent_to_kill/models/witness_statement.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:intent_to_kill/screens/pick_class.dart';
import 'package:intent_to_kill/screens/settings_screen.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/components/widget_wrapper.dart';
import 'package:qoiu_utils/extensions/list_extensions.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class Notepad extends StatefulWidget {
  final NoteScreenController controller;
  final State parentState;

  const Notepad(
      {required this.controller, required this.parentState, super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}


Widget image(String path, double size) =>
    Image.asset(path, width: size, height: size, fit: BoxFit.cover);

class _NotepadState extends State<Notepad> {
  GlobalKey titleHeight = GlobalKey();
  OverlayPortalController settingsOverlay = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    var titleWidth = MediaQuery.of(context).size.width / 3;
    var itemWidth = (MediaQuery.of(context).size.width - titleWidth) / 11;
    return Column(children: [
      Table(
        border: TableBorder.all(color: AppTheme.grayFon2Color),
        columnWidths: {
          0: FlexColumnWidth(titleWidth),
          1: FlexColumnWidth(itemWidth * 2),
          2: FlexColumnWidth(itemWidth * 3),
          3: FlexColumnWidth(itemWidth * 3),
          4: FlexColumnWidth(itemWidth * 3),
        },
        children: [
          TableRow(children: [
            PopupMenu(
              fromLeft: true,
              follower: SquareCard(
                size: 320,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SettingsScreen.newDesignEditor(widget.parentState, 80),
                      SettingsScreen.newPopup(this),
                      SettingsScreen.newFont(this),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.all(10),
                        child: PatchContainer(
                          onTap: Navigator.of(context).pop,
                          child: const Text("В меню"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              controller: settingsOverlay,
              child: Container(
                  height: titleHeight.size()?.height,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings, size: 10),
                          const SizedBox(width: 5),
                          TextBuilder(getString().settings)
                              .alignCenter()
                              .ellipsis()
                              .build(),
                        ],
                      ),
                      Divider(color: getColorScheme().outline, height: 1),
                      TextBuilder(getString().param_requested)
                          .alignCenter()
                          .ellipsis()
                          .build(),
                    ],
                  )),
            ),
            Column(
              key: titleHeight,
              children: [
                TextBuilder(getString().param_gender)
                    .alignCenter()
                    .ellipsis()
                    .build(),
                const Divider(color: AppTheme.grayFon2Color, height: 1),
                Row(
                  children: [
                    Flexible(child: image('assets/icon/sex_m.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(child: image('assets/icon/sex_f.png', itemWidth)),
                  ],
                )
              ],
            ),
            Column(
              children: [
                TextBuilder(getString().param_age)
                    .alignCenter()
                    .ellipsis()
                    .build(),
                const Divider(color: AppTheme.grayFon2Color, height: 1),
                Row(
                  children: [
                    Flexible(child: image('assets/icon/age_20.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(child: image('assets/icon/age_40.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(child: image('assets/icon/age_60.png', itemWidth)),
                  ],
                )
              ],
            ),
            Column(
              children: [
                FittedBox(
                  child: TextBuilder(getString().param_size)
                      .alignCenter()
                      .ellipsis()
                      .build(),
                ),
                const Divider(color: AppTheme.grayFon2Color, height: 1),
                Row(
                  children: [
                    Flexible(child: image('assets/icon/size_s.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(child: image('assets/icon/size_m.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(child: image('assets/icon/size_l.png', itemWidth)),
                  ],
                )
              ],
            ),
            Column(children: [
              TextBuilder(getString().param_height)
                  .alignCenter()
                  .ellipsis()
                  .build(),
              const Divider(color: AppTheme.grayFon2Color, height: 1),
              Row(
                children: [
                  Flexible(child: image('assets/icon/height_s.png', itemWidth)),
                  dividerWidth(itemWidth),
                  Flexible(child: image('assets/icon/height_m.png', itemWidth)),
                  dividerWidth(itemWidth),
                  Flexible(child: image('assets/icon/height_l.png', itemWidth)),
                ],
              )
            ]),
          ])
        ],
      ),
      Flexible(
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ...widget.controller.notepad.statements.expand((stmnt) {
            var name = context.tr(stmnt.character.name);
            return [
              Table(
                  border: TableBorder.all(color: AppTheme.grayFon2Color),
                  columnWidths: {
                    0: FlexColumnWidth(titleWidth),
                    ...Map.fromEntries(List.generate(
                        11, (i) => MapEntry(i + 1, FlexColumnWidth(itemWidth))))
                  },
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                            color: (widget.controller.trusted
                                    .contains(stmnt.character.kClass)
                                ? Colors.green.withOpacity(0.1)
                                : Colors.transparent)),
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await editCharacter(stmnt);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: const EdgeInsets.all(5),
                                  color: Colors.transparent,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey.withAlpha(200),
                                    size: 10,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      child: CharacterItem(
                                          character: stmnt.character,
                                          imgWidth: 50,
                                          showName: false),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: name.length < 7
                                              ? TextBuilder(name).build()
                                              : FittedBox(
                                                  child: TextBuilder(name)
                                                      .build())),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppTheme.grayFon3Color))),
                              child:
                                  questionItem(stmnt.sexMale, stmnt.character)),
                          questionItem(stmnt.sexFemale, stmnt.character),
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppTheme.grayFon3Color))),
                              child:
                                  questionItem(stmnt.age20, stmnt.character)),
                          questionItem(stmnt.age40, stmnt.character),
                          questionItem(stmnt.age60, stmnt.character),
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppTheme.grayFon3Color))),
                              child:
                                  questionItem(stmnt.sizeS, stmnt.character)),
                          questionItem(stmnt.sizeM, stmnt.character),
                          questionItem(stmnt.sizeL, stmnt.character),
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      left: BorderSide(
                                          color: AppTheme.grayFon3Color))),
                              child:
                                  questionItem(stmnt.heightS, stmnt.character)),
                          questionItem(stmnt.heightM, stmnt.character),
                          questionItem(stmnt.heightL, stmnt.character)
                        ]),
                  ]),
              ...stmnt.comments.where((e) => e.comment.isNotEmpty).map(
                    (e) => GestureDetector(
                      onTap: () async {
                        await editCharacter(stmnt);
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.all(5).copyWith(bottom: 0, top: 2),
                        child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: e.color.withAlpha(AppSettings.useNewStyle
                                    ? 255 -
                                        (160 * (AppSettings.newDesignOpacity))
                                            .toInt()
                                    : 255),
                                // color: e.color.withAlpha(90),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextBuilder(e.comment)
                                .style(AppSettings.commentCasualFont
                                    ? AppTheme.noteStyle
                                    : getTextStyle().bodyMedium)
                                .build()),
                      ),
                    ),
                  ),
              stmnt.comments.isNotEmpty
                  ? const SizedBox(height: 5)
                  : Container(),
            ];
          })
        ])),
      ),
      GestureDetector(
          onTap: pickCharacter,
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.transparent,
              child: TextBuilder("Выберите персонажа").build())),
      const Divider(height: 1, color: AppTheme.grayFon2Color)
    ]);
  }

  Future<void> editCharacter(WitnessStatement stmnt) async {
    var result =
        await showBottomModal(builder: (c) => WitnessCommentModal(stmnt));
    if (result == 'save') {
      widget.controller.saveGame();
      setState(() {});
    }
    if (result == 'change') {
      pickCharacter(stmnt);
    }
  }

  Container dividerWidth(double itemWidth) {
    return Container(
        width: 1, height: itemWidth, color: AppTheme.grayFon2Color);
  }

  pickCharacter([WitnessStatement? stmnt]) async {
    var kClass = await showAdminModal(Container(
        padding: const EdgeInsets.all(20),
        child: AppCard(
            intrinsicWidth: false,
            child: Column(
              children: [
                Expanded(
                  child: PickClass(
                    title: getString().pick_class,
                    showBackground: false,
                  ),
                ),
                if (AppSettings.useNewStyle) ...{const SizedBox(height: 160)},
              ],
            ))));
    if (kClass is KillerClass) {
      var character = await PickCharacterModal(killerClass: kClass).show();
      if (character is KillerCharacter) {
        if (stmnt == null) {
          widget.controller.notepad.statements
              .add(WitnessStatement(character: character));
        } else {
          stmnt.character = character;
        }
        widget.controller.saveGame();
        MainUpdateWidget.of(context).update();
        setState(() {});
      }
    }
  }

  Widget questionItem(QuestionStatement statement, KillerCharacter from) {
    return AppSettings.useNewPopup
        ? PopupMenu(
            follower: SquareCard(
                child: Column(children: [
              Center(
                child: FittedBox(
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextBuilder(getString()
                                .killer_question(context.tr(from.name)))
                            .titleMedium()
                            .build(),
                        Image.asset(statement.icon, width: 30, height: 30),
                        TextBuilder('?').titleMedium().build(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  mainItem(statement, 60, KillerStatement.empty,
                      'assets/icon/cancel.png'),
                  mainItem(statement, 60, KillerStatement.yes,
                      'assets/icon/yes.png'),
                  mainItem(
                      statement, 60, KillerStatement.no, 'assets/icon/no.png'),
                ],
              ),
              if (AppSettings.useNewStyle) ...{
                const SizedBox(height: 40),
              }
            ])),
            controller: statement.overlayPortalController,
            child: questionItemContent(statement),
            onClose: () => setState(() {}),
            onOpen: () => setState(() {}),
          )
        : GestureDetector(
            onTap: () async {
              await showAdminModal(EditQuestionStatementModal(
                  statement: statement,
                  from: from,
                  onTap: () => setState(() {})));
              widget.controller.saveGame();
              setState(() {});
            },
            child: questionItemContent(statement),
          );
  }

  Widget mainItem(QuestionStatement statement, double itemWidth,
      KillerStatement require, String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          statement.answer = require;
        });
        statement.overlayPortalController.hide();
        // widget.parentState.setState(() {});
      },
      child: WidgetWrapper(
        condition: false,
        // condition: statement.answer == require,
        wrap: (child) => PopupMenu(
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.center,
            follower: Container(
                width: 140,
                height: 140,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Color(0x00000000),
                    Color(0x99000000),
                    Color(0x99000000),
                    Color(0x00000000)
                  ], stops: [0, 0.5, 0.7, 1]),
                ),
                child: Stack(
                  children: [
                    ...appColors.indexedMap((i, e) {
                      var value = (i / appColors.length) * 270;
                      ['value', value].print();
                      ['value - sin', sin(value)].print();
                      ['value - cos', cos(value)].print();
                      return Align(
                        alignment: Alignment(sin(value), cos(value)),
                        child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorExtension.fromCode(e),
                            )),
                      );
                    })
                  ],
                )),
            controller: statement.overlayColorPortalController,
            child: child),
        child: Container(
            width: itemWidth,
            height: itemWidth,
            decoration: BoxDecoration(
                border: statement.answer == require
                    ? Border.all(color: getColorScheme().primary)
                    : null,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              // color: Colors.red,
              colorBlendMode: BlendMode.srcATop,
            )),
      ),
    );
  }

  Container questionItemContent(QuestionStatement statement) {
    return Container(
      color: Colors.transparent,
      width: double.maxFinite,
      alignment: Alignment.center,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Opacity(
                opacity: statement.overlayPortalController.isShowing ? 1 : 0.3,
                child: Image.asset(statement.icon, width: 10, height: 10)),
          ),
          statement.answer == KillerStatement.empty
              ? Container()
              : Image.asset(
                  statement.answer == KillerStatement.yes
                      ? 'assets/icon/yes.png'
                      : 'assets/icon/no.png',
                  fit: BoxFit.fitWidth)
        ],
      ),
    );
  }
}

class NotepadController {
  List<WitnessStatement> statements = [];

  NotepadController();

  NotepadController.fromJson(Map<String, dynamic> json) {
    statements =
        appParseList(json['statements'], (e) => WitnessStatement.fromJson(e));
  }

  Map<String, dynamic> toJson() =>
      {'statements': statements.map((e) => e.toJson()).toList()};
}
