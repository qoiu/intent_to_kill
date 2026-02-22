import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/enum/characters.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

class CharacterSigned extends StatelessWidget {
  final KillerCharacter character;
  final bool showClass;
  final bool isGray;
  final bool showStats;
  final bool showName;

  const CharacterSigned(this.character,
      {this.showClass = false,
      this.isGray = false,
      this.showStats = false,
      this.showName = false,
      super.key});

  const CharacterSigned.withClass(this.character,
      {this.isGray = false,
      this.showStats = false,
      this.showName = false,
      super.key})
      : showClass = true;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: 150,
        height: showName?165:150,
        child: Stack(
          children: [
            if (showStats) ...{
              Transform.translate(
                  offset: Offset(0, 46),
                  child: Container(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: Material(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      elevation: 4,
                      child: Container(
                          padding: EdgeInsets.all(5).copyWith(top: 30),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: const AssetImage(
                                      'assets/images/notepad_background.jpg'),
                                  fit: BoxFit.cover,
                                  alignment: AlignmentGeometry.topCenter),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          width: 150,
                          child: CharacterStats(character)),
                    ),
                  )),
            },
            Container(
              alignment: AlignmentGeometry.topCenter,
              width: 150,
              height: 150,
              child: Image.asset(
                'assets/char/${character.name}.jpg',
                colorBlendMode: isGray ? BlendMode.saturation : null,
                color: isGray ? AppTheme.grayFon3Color : null,
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: showName
                            ? Transform.translate(
                                offset: Offset(-10, 6),
                                child: FittedBox(
                                  child: Container(
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/patch_1.png'),
                                        fit: BoxFit.fill,
                                      )),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5)
                                          .copyWith(left: 5),
                                      child: Text(
                                        context.tr(character.name),
                                        style: getTextStyle().titleMedium,
                                      )),
                                ))
                            : Container(),
                      ),
                      if (showClass) ...{
                        Transform.translate(
                            offset: Offset(0, showName?-15:0),
                            child: Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                  'assets/class/${character.kClass.name}.jpg',
                                  fit: BoxFit.fill),
                            ))
                      }
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
