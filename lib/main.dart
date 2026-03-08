import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intent_to_kill/screens/menu.dart';
import 'package:intent_to_kill/secrets.dart';
import 'package:intent_to_kill/utils/app_settings.dart';
import 'package:intent_to_kill/utils/metrica.dart';
import 'package:intent_to_kill/utils/precache_images.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intent_to_kill/utils/update_inherit.dart';
import 'package:qoiu_utils/navigation.dart';
import 'package:qoiu_utils/qoiu_utils.dart';

import 'l10n/app_localizations.dart';

final InAppReview inAppReview = InAppReview.instance;
ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('ru'));
List<Locale> availableLocals = const [
  Locale('en'),
  Locale('ru', 'RU'),
];


void main() async {
  Intl.defaultLocale = 'ru';
  Intl.systemLocale = 'ru';
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppSharedPreference.init();
  appLocale.value = AppSharedPreference.getLang()?.let((lang){
    return availableLocals.where((e)=>e.languageCode==lang).first;
  })??WidgetsBinding.instance.platformDispatcher.locale.let((e){
    return availableLocals.map((e)=>e.languageCode).contains(e.languageCode)?e:availableLocals.first;
  })??availableLocals.first;
  if(appMetricaKey.isNotEmpty){
    try {
      await AppMetrica.activate(
          AppMetricaConfig(appMetricaKey));
      'metrica active'.dpRed().print();
    }on Exception catch(e){
      'metrica error'.dpRed().print();
      e.toString().print();
    }
    if(AppSettings.getAppVersion()){
      Metrica.sendEvent('Launch app(${appLocale.value.languageCode})');
    }else {
      Metrica.sendEvent('Launch app(${appLocale.value.languageCode}) - $appVersion');
    }
  }
  AppSettings.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));
  runApp(EasyLocalization(
      supportedLocales: availableLocals,
      path: 'assets/translate',
      fallbackLocale: Locale('ru', 'RU'),
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Uint8List? bytes;

  @override
  State<MyApp> createState() => _MyAppState();
}

UpdateController mainUpdater = UpdateController();

class _MyAppState extends State<MyApp> with UpdaterMixin {
  @override
  void initState() {
    updateController = mainUpdater;
    super.initState();
    appLocale.addListener(update);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PrecacheImages.precacheImages(context);
    });
  }

  @override
  dispose() {
    appLocale.removeListener(update);
    'main: dispose'.dpRed().print();
    super.dispose();
  }

  update() {
    'update main'.dpGreen().print();
    setState(() {});
  }


  // Positioned.fill(
  // child: Opacity(
  // opacity: AppSettings.newDesignOpacity,
  // child: Image.asset(
  // 'assets/images/notepad_background.jpg',
  // fit: BoxFit.fill,
  // ),
  // ),
  // ),

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.mainTheme,
        navigatorKey: rootNavigatorKey,
        color: Colors.transparent,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          ...context.localizationDelegates
        ],
        supportedLocales: availableLocals,
        locale: appLocale.value,
        home: const Menu(),
        // builder: (context, child) => AppShell(
        //   child: Material(
        //     type: MaterialType.transparency,
        //     child: child ?? const SizedBox.shrink(),
        //   ),
        // )
        // Container(
        //       color: Colors.white,
        //       child: Stack(
        //         children: [
        //           Scaffold(
        //               backgroundColor: Colors.transparent,
        //               body: child ?? Container()),
        //         ],
        //       )),
        );
  }
}

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppTheme.white,
            child: Opacity(
              opacity: AppSettings.newDesignOpacity,
              child: Image.asset(
                'assets/images/notepad_background.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        child
      ],
    );
  }
}

class _AppBackground extends StatelessWidget {
  const _AppBackground();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        color: AppTheme.white,
        child: Opacity(
          opacity: AppSettings.newDesignOpacity,
          child: Image.asset(
            'assets/images/notepad_background.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
class StableBackground extends StatefulWidget {
  const StableBackground();

  @override
  State<StableBackground> createState() => _StableBackgroundState();
}

Image? _image;
class _StableBackgroundState extends State<StableBackground> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        color: AppTheme.white,
        width: double.maxFinite,
        height: double.maxFinite,
        child: Opacity(
          opacity: AppSettings.newDesignOpacity,
          child: Image.memory(MyApp.bytes!, fit: BoxFit.fill,)
        ),
      ),
    );
  }
}
