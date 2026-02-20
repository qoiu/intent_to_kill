import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/app_card.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/enum/motivation.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/extensions/list_extensions.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

import '../utils/themes.dart';

class PickMotivationsModal extends StatefulWidget {
  final int required;
  final String? title;

  const PickMotivationsModal({super.key, required this.required, this.title});

  @override
  State<PickMotivationsModal> createState() => _PickMotivationsModalState();
}

class _PickMotivationsModalState extends State<PickMotivationsModal> {
  List<KillerMotivation> selected =
      List<KillerMotivation>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    var itemWidth = (MediaQuery.of(context).size.width - 200) / 2;
    return SizedBox(
      width: (MediaQuery.of(context).size.width -
          (AppSettings.useNewStyle ? 0 : 80)),
      child: AppCard(
        canUseNewDesign: false,
        intrinsicWidth: true,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextBuilder(widget.title ?? getString().pick_motivations)
                .titleMedium()
                .build(),
            const SizedBox(height: 20),
            Wrap(
              runSpacing: 10,
              children: KillerMotivation.values
                  .map((e) => GestureDetector(
                        onTap: () => setState(() {
                          selected.join(',').dpRed().print();
                          selected.addOrRemove(e);
                          selected.join(',').dpGreen().print();
                        }),
                        child: Container(
                          width: itemWidth,
                          decoration: BoxDecoration(
                              border: selected.contains(e)
                                  ? Border.all(color: Colors.red, width: 3)
                                  : null),
                          child: Column(
                            children: [
                              Image.asset(
                                e.image(),
                                colorBlendMode: !selected.contains(e)
                                    ? BlendMode.saturation
                                    : null,
                                color: !selected.contains(e)
                                    ? AppTheme.grayFon3Color
                                    : null,
                              ),
                              TextBuilder(e.title(context))
                                  .maxLines(1)
                                  .ellipsis()
                                  .build(),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            MainButton(getString().random, () {
              selected = [];
              while (selected.length < widget.required) {
                selected.add(KillerMotivation.values
                    .where((e) => !selected.contains(e))
                    .toList()
                    .random());
              }
              setState(() {});
            }),
            const SizedBox(height: 20),
            MainButton(
                '${getString().apply}${selected.length == widget.required ? '' : ' (${selected.length}/${widget.required})'}',
                () => Navigator.of(context).pop(selected),
                isActive: selected.length == widget.required),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
