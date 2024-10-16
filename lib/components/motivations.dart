import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class MotivationsList extends StatelessWidget {
  final List<KillerMotivation> motivations;
 final bool Function(KillerMotivation) isTrusted;
 final Function(KillerMotivation) onTap;

  const MotivationsList({required this.motivations, required this.onTap, required this.isTrusted, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: motivations.length < 7
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: motivations.map((motive) {
                return Flexible(
                  child: motiveItem(motive, context),
                );
              }).toList(),
            )
          : Wrap(
              children: motivations.map((motive) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: motiveItem(motive, context),
                );
              }).toList(),
            ),
    );
  }

  Widget motiveItem(KillerMotivation motive, BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(motive),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/motive/back.png'),
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isTrusted(motive) ? 0.3 : 1,
                  child: Image.asset(motive.image())),
            ],
          ),
          FittedBox(
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isTrusted(motive) ? 0.3 : 1,
                  child: TextBuilder(motive.title(context)).build()))
        ],
      ),
    );
  }
}
