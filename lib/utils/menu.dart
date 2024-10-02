import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/enum/classes.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((a){
      context.tr('auth').dpGreen().print();
      KillerClass.values.forEach((cl){
        var chars = KillerCharacter.values.where((ch)=>ch.kClass==cl).length;
        '$cl=>$chars'.dpGreen().print();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextBuilder(Intl.systemLocale).build(),
        TextBuilder(Intl.defaultLocale??'default: null').build(),
        TextBuilder(Intl.message('', name: 'auth')).build(),
      ],
    );
  }
}
