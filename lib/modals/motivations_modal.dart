import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/screens/notes_screen.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class MotivationsModal extends StatefulWidget {
  final NoteScreenController controller;
  final Function(KillerMotivation motive) onTap;
  final bool Function(KillerMotivation motive) isTrusted;

  const MotivationsModal(this.controller, {super.key, required this.onTap, required this.isTrusted});

  @override
  State<MotivationsModal> createState() => _MotivationsModalState();
}

class _MotivationsModalState extends State<MotivationsModal> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                          child: Container(width: (MediaQuery.of(context).size.width-30)/3, color: Colors.black, child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: widget.isTrusted(e) ? 0.3 : 1,
                          child:Image.asset(e.imageFull()))),
                        ))
                        .toList()))
          ],
        ),
      ),
    );
  }
}
