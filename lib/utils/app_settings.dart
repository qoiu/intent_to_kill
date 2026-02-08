
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:qoiu_utils/qoiu_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _newDesignKey = 'settings/new_design';
String _newCasualFontKey = 'settings/new_casual_font';
String _newPopupKey = 'settings/new_popup';

abstract class AppSettings {

  static double newDesignOpacity = 0.7;
  static bool get useNewStyle => newDesignOpacity>0.1;
  static bool _useNewPopup = true;
  static bool get useNewPopup => _useNewPopup;
  static bool _commentCasualFont = false;
  static bool get commentCasualFont => _commentCasualFont;

  static SharedPreferences get prefs => AppSharedPreference.prefs;

  static init(){
    AppSettings.newDesignOpacity = prefs.getDouble(_newDesignKey) ?? 0.75;
    AppSettings._useNewPopup = prefs.getBool(_newPopupKey) ?? true;
    ['_useNewPopup',_useNewPopup].print();
    AppSettings._commentCasualFont = prefs.getBool(_newCasualFontKey) ?? false;
    ['_commentCasualFont',_commentCasualFont].print();
  }

  static updateDesign() {
    AppSharedPreference.prefs.setDouble(_newDesignKey, AppSettings.newDesignOpacity);
  }

  static updateNewPopup(bool value){
    _useNewPopup = value;
    prefs.setBool(_newPopupKey, value);
  }

  static updateCasualFont(bool value){
    _commentCasualFont = value;
    prefs.setBool(_newCasualFontKey, value);
  }


}