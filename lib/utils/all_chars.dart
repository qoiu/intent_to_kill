import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class AllChars extends StatelessWidget {
  const AllChars({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: KillerCharacter.values
          .map((character) => Column(
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/char/${character.name}.jpg',
                          width: 100, height: 100),
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/class/${character.kClass.name}.jpg',
                            width: 20, height: 20),
                      )
                    ],
                  ),
                  TextBuilder(context.tr(character.name)).build(),
                ],
              ))
          .toList(),
    );
  }
}
