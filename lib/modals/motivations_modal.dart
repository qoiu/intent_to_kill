import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class MotivationsModal extends StatefulWidget {
  final NoteScreenController controller;
  final Function(KillerMotivation motive) onTap;
  final bool Function(KillerMotivation motive) isTrusted;

  const MotivationsModal(this.controller,
      {super.key, required this.onTap, required this.isTrusted});

  @override
  State<MotivationsModal> createState() => _MotivationsModalState();
}

class _MotivationsModalState extends State<MotivationsModal> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
        canUseNewDesign: false,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBuilder('Мотивы').titleLarge().build(),
          Expanded(
              child: Wrap(
                spacing: 1,
                  runSpacing: 1,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: widget.controller.motivations
                      .map((e) => InkWell(
                    onTap: (){
                      widget.onTap(e);
                      setState(() {});
                    },
                        child: Container(width: (MediaQuery.of(context).size.width-30)/3, height: ((MediaQuery.of(context).size.width-30)/3)*1.55, color: Colors.black, child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: widget.isTrusted(e) ? 0.3 : 1,
                        child:
                        // Container(color: Colors.red,)
                        MotiveCard(e)
                        )),
                      ))
                      .toList()))
        ],
      ),
    );
  }
}

class MotiveCard extends StatelessWidget {
  final KillerMotivation motivation;

  const MotiveCard(this.motivation, {super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Container(
          width: 325,
          height: 500,
          child: Stack(
            children: [
              Image.asset(motivation.imageFull()),
              Align(
                alignment: Alignment(0.1, 1),
                child: Container(
                  width: 280,
                  height: 110,
                  child: Text(motivation.description(context),style: getTextStyle().bodyMedium?.copyWith(fontSize: motivation.description(context).length<40?20:16),),
                ),
              ),
              Align(
                alignment: Alignment(0.1, 0.5),
                child: Container(
                  width: 160,
                  height: 35,
                  child: Text(motivation.title(context), style: getTextStyle().titleMedium?.copyWith(fontSize: 28),),
                ),
              ),
              Align(
                alignment: Alignment(0.1, 0.42),
                child: Container(
                  width: 160,
                  height: 25,
                  child: Text(getString().motivation_killer, style: getTextStyle().titleMedium?.copyWith(fontSize: 18, color: Colors.grey),),
                ),
              )
            ],
          ),
        ));
  }
}
