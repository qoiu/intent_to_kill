import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/components/killer_stats.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/components/mouse_clicker.dart';
import 'package:intent_to_kill/components/visible_clicker.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class ConfirmKillerModal extends StatelessWidget {
  final KillerController controller;

  const ConfirmKillerModal(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      intrinsicWidth: true,
      child: Column(children: [
        IntrinsicHeight(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    VisibleClicker(
                        onTap: () {
                          controller.clearKiller();
                          Navigator.of(context).pop(false);
                        },
                        child: Column(
                          children: [
                            TextBuilder(getString().killer)
                                .labelMedium()
                                .build(),
                            const SizedBox(height: 5),
                            Flexible(
                              child: CharacterItem(
                                character: controller.killer,
                                imgWidth: 66,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(width: 5),
                    Container(
                        height: 110, width: 1, color: AppTheme.grayFon2Color),
                    const SizedBox(width: 5),
                    VisibleClicker(
                      onTap: () {
                        controller.clearFigure();
                        Navigator.of(context).pop(false);
                      },
                      child: Column(
                        children: [
                          TextBuilder(getString().helper).labelMedium().build(),
                          const SizedBox(height: 5),
                          Flexible(
                            child: CharacterItem(
                              character: controller.figure,
                              imgWidth: 66,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                        height: 110, width: 1, color: AppTheme.grayFon2Color),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        children: [
                          TextBuilder(getString().assistance_class)
                              .labelMedium()
                              .build(),
    VisibleClicker(
    onTap: (){
    controller.clearClass();
    Navigator.of(context).pop(false);
    },
    child: Row(
                            children: [
                              Image.asset(
                                controller.minionClass.image,
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                              Expanded(
                                  child: TextBuilder(context
                                          .tr(controller.minionClass.name))
                                      .labelLarge()
                                      .ellipsis()
                                      .build()),
                            ],
                          )),
                          const SizedBox(height: 10),
                          const Divider(
                              color: AppTheme.grayFon2Color, height: 1),
                          const SizedBox(height: 20),
    VisibleClicker(
    onTap: (){
    controller.clearMotive();
    Navigator.of(context).pop(false);
    },
    child:Container(
                            alignment: Alignment.topLeft,
                            child: RichTextBuilder([
                              TextBuilder(getString().motivation),
                              TextBuilder(controller.motivation.title(context)),
                            ]).build(),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(color: AppTheme.grayFon2Color, height: 1),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextBuilder(getString().param_killer).build(),
                    Expanded(child: CharacterStats(controller.killer))
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Center(
            child: MainButton(
                getString().start, () => Navigator.of(context).pop(true),
                fill: false))
      ]),
    );
  }
}
