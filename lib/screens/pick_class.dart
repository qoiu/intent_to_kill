import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/screen_template.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class PickClass extends StatefulWidget {
  final String? title;
  final bool showBackground;
  const PickClass({super.key, this.title, this.showBackground=true});

  @override
  State<PickClass> createState() => _PickClassState();
}

class _PickClassState extends State<PickClass> {
  GlobalKey columnSize = GlobalKey();
  @override
  Widget build(BuildContext context) {
    'height: ${columnSize.size()?.height}'.print();
    return ScreenTemplate(
      showBackground: widget.showBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextBuilder(widget.title??getString().pick_companions).titleLarge().build(),
          Expanded(key: columnSize,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: KillerClass.values
                .map((e) => Expanded(
                  child: GestureDetector(
                    onTap: ()async{
                        Navigator.of(context).pop(e);
                        },
                    child: Container(
                      color: Colors.transparent,
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
                  ),
                ))
                .toList(),
          ),)
        ],
      ),
    );
  }
}
