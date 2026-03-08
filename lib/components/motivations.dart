import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/main.dart';

class MotivationsList extends StatelessWidget {
  final List<KillerMotivation> motivations;
 final bool Function(KillerMotivation) isTrusted;
 final Function(KillerMotivation) onTap;

  const MotivationsList({required this.motivations, required this.onTap, required this.isTrusted, super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: motivations.map((motive) {
                return Flexible(
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
              Image.asset('assets/motive/back_${appLocale.value.languageCode}.jpg'),
              AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isTrusted(motive) ? 0.3 : 1,
                  child: Image.asset(motive.image())),
            ],
          ),
          SizedBox(
            height: 20,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: isTrusted(motive) ? 0.3 : 1,
                  child: AutoSizeText(motive.title(context), maxLines: 1, minFontSize: 3, maxFontSize: 10,)
    // TextBuilder(motive.title(context)).build()
    ))
        ],
      ),
    );
  }
}
