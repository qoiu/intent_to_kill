import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/enum/characers.dart';
import 'package:intent_to_kill/modals/confirm_modal.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class PickKillers extends StatelessWidget {
  final String? title;
  final KillerController controller;

  const PickKillers({super.key, this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    var imgWidth = MediaQuery.of(context).size.width / 6;
    var list = KillerCharacter.values.toList();
    list.sort((a, b) => context
        .tr(a.name)
        .toLowerCase()
        .compareTo(context.tr(b.name).toLowerCase()));
    list.sort((a, b) =>
        a.kClass.name.toLowerCase().compareTo(b.kClass.name.toLowerCase()));
    return SingleChildScrollView(
      child: Column(
        children: [
          if (title != null) ...{
            const SizedBox(height: 10),
            Center(
              child: TextBuilder(title!).titleMedium().build(),
            ),
          },
          const SizedBox(height: 10),
          Wrap(
            children: list
                .map((character) =>SizedBox(
                      width: imgWidth,
                      height: imgWidth * 1.25,
                      child: GestureDetector(
                        onTap: controller.roleAvailable(character)
                            ? () async {
                                var result = await ConfirmModal(getString()
                                        .pick_role_confirm(
                                            context.tr(character.name)))
                                    .show();
                                if (result == true) {
                                  controller.updateNext(character);
                                  Navigator.of(context).pop(controller);
                                }
                              }
                            : null,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  'assets/char/${character.name}.jpg',
                                  colorBlendMode:
                                      controller.roleAvailable(character)
                                          ? null
                                          : BlendMode.saturation,
                                  color: controller.roleAvailable(character)
                                      ? null
                                      : AppTheme.grayFon3Color,
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
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
