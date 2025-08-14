import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intent_to_kill/screens/all_chars.dart';
import 'package:intent_to_kill/screens/menu.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:intent_to_kill/utils/themes.dart';
import 'package:intl/intl.dart';
import 'package:qoiu_utils/navigation.dart';

import 'l10n/app_localizations.dart';

final InAppReview inAppReview = InAppReview.instance;

void main() async{
  Intl.defaultLocale = 'ru';
  Intl.systemLocale = 'ru';
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppSharedPreference.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light
  ));
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //       statusBarColor: Colors.white,
  //       statusBarBrightness: Brightness.dark,
  //       statusBarIconBrightness: Brightness.dark,
  //       systemNavigationBarColor: Colors.white,
  //       systemNavigationBarIconBrightness: Brightness.dark
  //   ),
  // );
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //   SystemUiOverlay.top
  // ]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translate',
      fallbackLocale: Locale('ru', 'RU'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.mainTheme,
      navigatorKey: rootNavigatorKey,
      color: AppTheme.mainBackgroundColor,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ...context.localizationDelegates],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const Menu(),
      builder: (context,child)=> Container(color: Colors.white, child: SafeArea(child: Scaffold(backgroundColor: Colors.white, body: child??Container()))),
    );
  }
}
