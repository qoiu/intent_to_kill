import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class CharacterItem extends StatelessWidget {
  final double imgWidth;
  final KillerCharacter character;
  final VoidCallback? onTap;
  bool isGray;
  bool showName;
  bool showStats;

  CharacterItem(
      {super.key,
      this.imgWidth = 125,
      required this.character,
      this.onTap,
        this.showName=true,
        this.showStats=false,
      this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgWidth,
      height: imgWidth * (1+(showName?0.25:0)+(showStats?0.25:0)),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/char/${character.name}.jpg',
                  colorBlendMode: isGray ? BlendMode.saturation : null,
                  color: isGray ? AppTheme.grayFon3Color : null,
                  width: imgWidth,
                  height: imgWidth,
                  fit: BoxFit.fill,
                ),
                Container(
                  width: imgWidth,
                  height: imgWidth,
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                      'assets/class/${character.kClass.name}.jpg',
                      width: imgWidth / 5,
                      height: imgWidth / 5,
                      fit: BoxFit.fill),
                )
              ],
            ),
            if(showStats)...{
              SizedBox(width: imgWidth, child: CharacterStats(character))
            },
            if(showName)...{
              Container(
                height: imgWidth * 0.25,
                alignment: Alignment.center,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextBuilder(context.tr(character.name))
                        .ellipsis()
                        .build(),
                  ),
                ),
              )
            }
          ]
        ),
      ),
    );
  }
}

class CharacterStats extends StatelessWidget {
  final KillerCharacter character;
  const CharacterStats(this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Image.asset(character.imgSex,fit: BoxFit.contain)),
        Flexible(child: Image.asset(character.imgAge,fit: BoxFit.contain)),
        Flexible(child: Image.asset(character.imgSize,fit: BoxFit.contain)),
        Flexible(child: Image.asset(character.imgHeight,fit: BoxFit.contain)),
      ],
    );
  }
}
