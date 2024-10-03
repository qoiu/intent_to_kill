import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/models/witness_statement.dart';
import 'package:intent_to_kill/screens/pick_class.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class Notepad extends StatefulWidget {
  final NotepadController controller;
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
    return Column(
      children: [
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
                      Flexible(
                          child: image('assets/icon/sex_m.png', itemWidth)),
                      dividerWidth(itemWidth),
                      Flexible(
                          child: image('assets/icon/sex_f.png', itemWidth)),
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
                      Flexible(
                          child: image('assets/icon/age_20.png', itemWidth)),
                      dividerWidth(itemWidth),
                      Flexible(
                          child: image('assets/icon/age_40.png', itemWidth)),
                      dividerWidth(itemWidth),
                      Flexible(
                          child: image('assets/icon/age_60.png', itemWidth)),
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
                      Flexible(
                          child: image('assets/icon/size_s.png', itemWidth)),
                      dividerWidth(itemWidth),
                      Flexible(
                          child: image('assets/icon/size_m.png', itemWidth)),
                      dividerWidth(itemWidth),
                      Flexible(
                          child: image('assets/icon/size_l.png', itemWidth)),
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
                    Flexible(
                        child: image('assets/icon/height_s.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(
                        child: image('assets/icon/height_m.png', itemWidth)),
                    dividerWidth(itemWidth),
                    Flexible(
                        child: image('assets/icon/height_l.png', itemWidth)),
                  ],
                )
              ]),
            ])
          ],
        ),
    Table(
    border: TableBorder.all(color: AppTheme.grayFon2Color),
    columnWidths: {
    0: FlexColumnWidth(titleWidth),
    ...Map.fromEntries(List.generate(11, (i)=>MapEntry(i+1, FlexColumnWidth(itemWidth))))
    },
    children: [
      TableRow(
    children: [
      GestureDetector(onTap:()async{
        var result = await showAdminModal(Container(padding: const EdgeInsets.all(20), child: const AppCard(intrinsicWidth:false, child: PickClass())));
        result.toString().print();
    },
          child: Container(color: Colors.transparent, child: TextBuilder("Не выбрано").build()))
    ]
    )
      ],
    )]);
  }

  Container dividerWidth(double itemWidth) {
    return Container(
                        width: 1,
                        height: itemWidth,
                        color: AppTheme.grayFon2Color);
  }
}

class NotepadController{
  List<WitnessStatement> statements;
  NotepadController({this.statements=const []});
}
