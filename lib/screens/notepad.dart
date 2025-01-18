import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/update_inherited.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/modals/edit_question_statement.dart';
import 'package:intent_to_kill/modals/pick_character.dart';
import 'package:intent_to_kill/models/witness_statement.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:intent_to_kill/screens/pick_class.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

import '../modals/confirm_modal.dart';

class Notepad extends StatefulWidget {
  final NoteScreenController controller;

  const Notepad({required this.controller, super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

Widget image(String path, double size) =>
    Image.asset(path, width: size, height: size, fit: BoxFit.cover);

class _NotepadState extends State<Notepad> {
  GlobalKey titleHeight = GlobalKey();

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
            Container(
                height: titleHeight.size()?.height,
                alignment: Alignment.center,
                child: TextBuilder(getString().param_requested)
                    .alignCenter()
                    .ellipsis()
                    .build()),
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
          child: Column(
            children: [
              Table(
                border: TableBorder.all(color: AppTheme.grayFon2Color),
                columnWidths: {
                  0: FlexColumnWidth(titleWidth),
                  ...Map.fromEntries(List.generate(
                      11, (i) => MapEntry(i + 1, FlexColumnWidth(itemWidth))))
                },
                children: [
                  ...widget.controller.notepad.statements.map((stmnt) {
                    var name = context.tr(stmnt.character.name);
                    return TableRow(
                      decoration: BoxDecoration(
                        color: widget.controller.trusted.contains(stmnt.character.kClass)?Colors.green.withOpacity(0.1):Colors.transparent
                      ),
                        children: [
                      GestureDetector(
                        onTap: () => pickCharacter(stmnt),
                        child: Row(
                          children: [
                            CharacterItem(
                                character: stmnt.character,
                                imgWidth: 50,
                                showName: false),
                            Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: name.length < 7
                                      ? TextBuilder(name).build()
                                      : FittedBox(
                                          child: TextBuilder(name).build())),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppTheme.grayFon3Color))),
                          child: questionItem(stmnt.sexMale)),
                      questionItem(stmnt.sexFemale),
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppTheme.grayFon3Color))),
                          child: questionItem(stmnt.age20)),
                      questionItem(stmnt.age40),
                      questionItem(stmnt.age60),
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppTheme.grayFon3Color))),
                          child: questionItem(stmnt.sizeS)),
                      questionItem(stmnt.sizeM),
                      questionItem(stmnt.sizeL),
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                      color: AppTheme.grayFon3Color))),
                          child: questionItem(stmnt.heightS)),
                      questionItem(stmnt.heightM),
                      questionItem(stmnt.heightL)
                    ]);
                  }),
                ],
              ),
            ],
          ),
        ),
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

  Container dividerWidth(double itemWidth) {
    return Container(
        width: 1, height: itemWidth, color: AppTheme.grayFon2Color);
  }

  pickCharacter([WitnessStatement? stmnt]) async {
    var kClass = await showAdminModal(Container(
        padding: const EdgeInsets.all(20),
        child: AppCard(intrinsicWidth: false, child: PickClass(title: getString().pick_class,))));
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

  Widget questionItem(QuestionStatement statement) {
    return GestureDetector(
      onTap: () async {
        await showAdminModal(EditQuestionStatementModal(
            statement: statement, onTap: () => setState(() {})));
        widget.controller.saveGame();
        setState(() {});
      },
      child: Container(
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
                  opacity: 0.3,
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
      ),
    );
  }
}

class NotepadController {
  List<WitnessStatement> statements = [];

  NotepadController();
  NotepadController.fromJson(Map<String,dynamic> json){
    statements = parseList(json['statements'],(e)=>WitnessStatement.fromJson(e));
  }

  Map<String,dynamic> toJson()=>{
    'statements': statements.map((e)=>e.toJson()).toList()
  };
}
