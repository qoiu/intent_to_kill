import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/modals/confirm_modal.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class PickClass extends StatefulWidget {
  final String? title;
  const PickClass({super.key, this.title});

  @override
  State<PickClass> createState() => _PickClassState();
}

class _PickClassState extends State<PickClass> {
  GlobalKey columnSize = GlobalKey();
  @override
  Widget build(BuildContext context) {
    'height: ${columnSize.size()?.height}'.print();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextBuilder(widget.title??getString().pick_companions).titleLarge().build(),
        Expanded(key: columnSize,child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: KillerClass.values
              .map((e) => GestureDetector(
                onTap: ()async{
                    Navigator.of(context).pop(e);
                    },
                child: Container(
                  height: ((columnSize.size()?.height??MediaQuery.of(context).size.height-100)/9)-5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/class/${e.name}.jpg',
                          fit: BoxFit.cover),
                      const SizedBox(width: 10),
                      Expanded(child: TextBuilder(context.tr(e.name)).labelMedium().build()),
                    ],
                  ),
                ),
              ))
              .toList(),
        ),)
      ],
    );
  }
}
