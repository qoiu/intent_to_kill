import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intent_to_kill/main.dart';

abstract class PrecacheImages {
  static Future precacheImages(BuildContext context) async {
    MyApp.bytes = (await rootBundle.load('assets/images/notepad_background.jpg')).buffer.asUint8List();
    await precacheImage(
        const AssetImage('assets/images/notepad_background.jpg'), context);
    await precacheImage(
        const AssetImage('assets/images/notepad_background2.jpg'), context);
    await precacheImage(
        const AssetImage('assets/images/notepad_bottom.png'), context);
    await precacheImage(
        const AssetImage('assets/images/notepad_height.png'), context);
    await precacheImage(
        const AssetImage('assets/images/notepad_mid.png'), context);
  }
}
