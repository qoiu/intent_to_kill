import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intent_to_kill/components/character_signed.dart';
import 'package:intent_to_kill/components/itk_checkbox.dart';
import 'package:intent_to_kill/components/mouse_clicker.dart';
import 'package:intent_to_kill/components/patch_container.dart';
import 'package:intent_to_kill/components/screen_template.dart';
import 'package:intent_to_kill/components/visible_clicker.dart';
import 'package:intent_to_kill/enum/characters.dart';
import 'package:intent_to_kill/main.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/metrica.dart';
import 'package:intent_to_kill/utils/utils.dart';
import 'package:qoiu_utils/components/common_text_builder.dart';
import 'package:qoiu_utils/qoiu_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static Widget newDesignEditor(State state, [double size=160])=>
      PatchContainer(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), child: Row(
        children: [
          Expanded(
            child: TextBuilder(getString().settings_new_design)
                .alignCenter()
                .ellipsis()
                .build(),
          ),
          Container(
            width: size,
            alignment: Alignment.center,
            child: Slider(
              value: AppSettings.newDesignOpacity,
              onChanged: (value) async {
                if (value == AppSettings.newDesignOpacity) return;
                var val = value;
                AppSettings.newDesignOpacity = value;
                state.setState(() {});
                await Future.delayed(const Duration(milliseconds: 500));
                if (val == AppSettings.newDesignOpacity) {
                  AppSettings.updateDesign();
                }
              },
              inactiveColor: getColorScheme().outline,
            ),
          ),
        ],
      )
      );
  static Widget newPopup(State state) =>ITKCheckbox(
    state: AppSettings.useNewPopup,
    text: getString().settings_new_popup,
    onChange: () {
      state.setState(() {
        AppSettings.updateNewPopup(!AppSettings.useNewPopup);
      });
    },
  );
  static Widget showStatsWhenSelect(State state) =>ITKCheckbox(
    state: AppSettings.showStatsWhenSelect,
    text: getString().settings_new_popup,
    onChange: () {
      state.setState(() {
        AppSettings.updateShowStatsWhenSelect(!AppSettings.showStatsWhenSelect);
      });
    },
  );
  static Widget newFont(State state) =>
      ITKCheckbox(
          state: !AppSettings.commentCasualFont,
          text: getString().settings_new_font,
          onChange: () {
            state.setState(() {
              AppSettings.updateCasualFont(!AppSettings.commentCasualFont);
            });
          });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    Metrica.sendEvent('show settings');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                child: PatchContainer(child: VisibleClicker(onTap: Navigator.of(context).pop, child: const Icon(Icons.arrow_back_ios))),
              ),
              patchText2(Text(
                  getString().settings,
                  style: getTextStyle().titleMedium,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SettingsScreen.newDesignEditor(this),
        SettingsScreen.newPopup(this),
        SettingsScreen.newFont(this),
        const Spacer(),
        Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Metrica.sendEvent('show tg');
                  launchUrl(Uri.parse('https://t.me/intent_to_kill'));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        // color: Colors.red,
                        child: Transform.rotate(
                          angle: -0.1,
                          child: const CharacterSigned(KillerCharacter.jrnlst),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          child: FittedBox(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 220,
                              height: 120,
                              child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/patch_2.png'),
                                          fit: BoxFit.fill,
                                          alignment:
                                              AlignmentGeometry.topCenter)),
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: AutoSizeText(
                                              "Нашли багу, или есть интересные идеи?")),
                                      const SizedBox(width: 10),
                                      Container(
                                        width: 60,
                                        padding: EdgeInsetsGeometry.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/Telegram_2019_Logo.svg.png',
                                              width: 40,
                                            ),
                                            const SizedBox(height: 5),
                                            AutoSizeText(
                                              'Поделитесь!',
                                              maxLines: 1,
                                              minFontSize: 3,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 20),
        Table(
            // border: TableBorder.all(color: AppTheme.grayFon2Color),
            columnWidths: {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  GestureDetector(
                    onTap: (){
                      Metrica.sendEvent('TapGoogle');
                      launchUrl(Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.qoiu.intent_to_kill'));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image.asset(
                            'assets/images/google.jpeg',
                          )),
                    ),
                  ),
                  MouseClicker(
                    onTap: () {
                      Metrica.sendEvent('TapSea_of_cloud');
                      launchUrl(Uri.parse(
                          'https://play.google.com/store/apps/details?id=com.qoiu.sea_of_cloud_counter'));
                    },
                    child: Column(
                      children: [
                        Container(
                            height: 70,
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  alignment: AlignmentGeometry.topCenter,
                                  padding: EdgeInsetsGeometry.only(top: 4),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(10),
                                    child: Image.asset(
                                      'assets/images/sea_of_clouds_logo.png',
                                      height: 50,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentGeometry.bottomCenter,
                                  child: Container(
                                      height: 30,
                                      child: patchText2(AutoSizeText(
                                        "Море облаков",
                                        minFontSize: 3,
                                        maxLines: 1,
                                      ))),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Metrica.sendEvent('TapAppReview');
                      if (await inAppReview.isAvailable()) {
                        'appReview available'.dpRed().print();
                        await inAppReview.requestReview();
                        'appReview showned'.dpRed().print();
                      } else {
                        launchUrl(Uri.parse(
                            'https://play.google.com/store/apps/details?id=com.qoiu.intent_to_kill'));
                        'appReview unavailable'.dpRed().print();
                      }
                    },
                    child: Container(
                        height: 70,
                        color: Colors.transparent,
                        child: Container(
                            alignment: AlignmentGeometry.bottomRight,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: patchText2(Column(
                                children: [
                                  Expanded(
                                      child:
                                          AutoSizeText("Оцените приложение")),
                                  Row(
                                      children: List.generate(
                                          5,
                                          (i) => Expanded(
                                                  child: Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              )))),
                                  const SizedBox(height: 6),
                                ],
                              )),
                            ))),
                  ),
                ],
              ),
            ]),
        const SizedBox(height: 20),
      ]),
    );
  }

  Container patchText2(Widget child, [EdgeInsets padding = const EdgeInsets.all(10)]) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/patch_2.png'),
                fit: BoxFit.fill,
                alignment: AlignmentGeometry.topCenter)),
        padding: padding,
        child: child);
  }

}
