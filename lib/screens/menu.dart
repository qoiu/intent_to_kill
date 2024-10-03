import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/modals/pick_role.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/screens/all_chars.dart';
import 'package:intent_to_kill/screens/notepad.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: double.maxFinite, height: double.maxFinite, child: Opacity(opacity:0.3, child: Image.asset('assets/images/back.jpg', fit: BoxFit.cover))),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextBuilder(getString().app_name).titleLarge().build(),
              // MainButton(getString().start, ()=>Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const AllChars())))
              MainButton(getString().start, ()async{
                var result = await PickRoleModal().show();
                if(result==KillerRole.detective){
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Notepad(controller: NotepadController(),)));
                }
                if(result==KillerRole.killer){
                  KillerController controller = KillerController();
                  while(!controller.allDone){
                    var result = await controller.getNextPage(context);
                    'result: $result'.print();
                    if(result==null){
                      'Выбор не завершён'.print();
                      break;
                    }
                  }
                  if(controller.allDone){
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Notepad(controller: NotepadController())));
                    'FINISH!'.dpGreen().print();
                  }
                }
    })
            ],
          ),
        ),
      ],
    );
  }
}
