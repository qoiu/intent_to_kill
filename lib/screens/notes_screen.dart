import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/killer_stats.dart';
import 'package:intent_to_kill/components/update_inherited.dart';
import 'package:intent_to_kill/enum/classes.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/enum/role.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/screens/notepad.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class NotesScreen extends StatefulWidget {
  final KillerController? killerController;
  final List<KillerMotivation> motivations;

  const NotesScreen({super.key, this.killerController, required this.motivations});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final NoteScreenController controller = NoteScreenController();
  bool showInfo = false;
  GlobalKey bottomKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    controller.motivations = widget.motivations;
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
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.motivations.map((motive){
                return Flexible(
                  child: Column(
                    children: [
                      Image.asset(motive.image()),
                      FittedBox(child: TextBuilder(motive.title(context)).build())
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: KillerClass.values.map((e) => classItem(e)).toList(),
          ),
          GestureDetector(
              onTap: () {
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
                        child: Image.asset(widget.killerController == null
                            ? 'assets/images/detective.png'
                            : 'assets/images/knife.png'),
                      ),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(0, showInfo ? 0 : 1),
                        child: widget.killerController != null
                            ? KillerStats(
                                controller: widget.killerController!,
                                globalKey: bottomKey,
                              )
                            : Container(color: Colors.white),
                      ),
                      Center(
                        child: AnimatedOpacity(
                          opacity: controller.showBottomHint ? 1 : 0,
                          duration: const Duration(milliseconds: 500),
                          child: AppCard(
                            color: getColorScheme().surface.withOpacity(0.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextBuilder(widget.killerController == null
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
  final NotepadController notepad = NotepadController();
  Set<KillerClass> epsent = {};
  Set<KillerClass> trusted = {};
  bool showBottomHint = true;
  List<KillerMotivation> motivations=[];
}
