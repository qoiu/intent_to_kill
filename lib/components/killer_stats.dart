import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/character_item.dart';
import 'package:intent_to_kill/models/killer_controller.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';

class KillerStats extends StatelessWidget {
  final KillerController controller;
  final GlobalKey? globalKey;

  const KillerStats({super.key, this.globalKey, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Column(
                      children: [
                        TextBuilder(getString().killer).labelMedium().build(),
                        const SizedBox(height: 5),
                        Flexible(
                          child: CharacterItem(
                            character: controller.killer,
                            imgWidth: 66,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5),
                    Container(height: 110, width: 1, color: AppTheme.grayFon2Color),
                    const SizedBox(width: 5),
                    Column(
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
                    const SizedBox(width: 5),
                    Container(height: 110, width: 1, color: AppTheme.grayFon2Color),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Column(
                        children: [
                          TextBuilder(getString().assistance_class)
                              .labelMedium()
                              .build(),
                          Row(
                            children: [
                              Image.asset(
                                controller.minionClass.image,
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                              Expanded(
                                  child: TextBuilder(
                                          context.tr(controller.minionClass.name)).labelLarge()
                                      .ellipsis()
                                      .build()),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: AppTheme.grayFon2Color, height: 1),
                          const SizedBox(height: 20),
                          Container(
                            alignment: Alignment.topLeft,
                            child: RichTextBuilder([
                              TextBuilder(getString().motivation),
                              TextBuilder(controller.motivation.title(context)),
                            ]).build(),
                          )
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
      ),
    );
  }
}
