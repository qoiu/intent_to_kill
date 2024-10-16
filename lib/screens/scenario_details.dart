import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/main_button.dart';
import 'package:intent_to_kill/components/motivations.dart';
import 'package:intent_to_kill/enum/game_mode.dart';
import 'package:intent_to_kill/models/scenarios.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utills.dart';

class ScenarioDetails extends StatefulWidget {
  final Scenario scenario;
  final GameMode mode;

  const ScenarioDetails(
      {super.key, required this.scenario, required this.mode});

  @override
  State<ScenarioDetails> createState() => _ScenarioDetailsState();
}

class _ScenarioDetailsState extends State<ScenarioDetails> {
  bool showText = false;
  GlobalKey framekey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((a) async {
      await Future.delayed(DefaultDuration.defaultDuration);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(widget.scenario.image),
              ),
              GestureDetector(
                onTap: () => setState(() => showText = !showText),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: AnimatedSlide(
                    duration: DefaultDuration.defaultDuration,
                    offset: showText ? const Offset(0, 0) : const Offset(0, -1),
                    child: AnimatedRotation(
                      duration: DefaultDuration.defaultDuration,
                      turns: showText ? 0 : 0.02,
                      child: Stack(
                        children: [
                          Image.asset('assets/scenario/scenario_back.png',
                              key: framekey),
                          Container(
                            width: framekey.size()?.width ??
                                MediaQuery.of(context).size.width / 2,
                            height: framekey.size()?.height ??
                                MediaQuery.of(context).size.height / 2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: double.maxFinite,
                                  height: 50,
                                ),
                                FittedBox(
                                    child:
                                        TextBuilder(widget.scenario.title)
                                            .bodyLarge()
                                            .build()),
                                Expanded(
                                    child: AutoSizeText(context
                                        .tr(widget.scenario.description))),
                                if (widget.scenario.agent != null) ...{
                                  Container(
                                      padding: const EdgeInsets.only(
                                        right: 20
                                      ),
                                      alignment: Alignment.bottomRight,
                                      child: Transform.rotate(
                                        angle: 0.08,
                                        child: Container(
                                          height: (framekey.size()?.height ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  2) /
                                              5,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                    'assets/char/${widget.scenario.agent!}.jpg',
                                                    fit: BoxFit.fitHeight),
                                              ),
                                              TextBuilder(context
                                                  .tr(widget.scenario.agent!))
                                                  .build(),
                                            ],
                                          ),
                                        ),
                                      ))
                                },
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        MotivationsList(
            motivations: widget.scenario.motivations
                .take(widget.mode.requiredMotive)
                .toList(),
            onTap: (m) {},
            isTrusted: (m) => false),
        const SizedBox(height: 10),
        MainButton(getString().start, () => Navigator.of(context).pop(true)),
        const SizedBox(height: 40),
      ],
    );
  }
}
