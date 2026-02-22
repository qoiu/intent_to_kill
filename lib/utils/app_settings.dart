
import 'package:intent_to_kill/screens/menu.dart';
import 'package:intent_to_kill/utils/shared_preference.dart';
import 'package:qoiu_utils/qoiu_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _newDesignKey = 'settings/new_design';
String _newCasualFontKey = 'settings/new_casual_font';
String _newPopupKey = 'settings/new_popup';
String _newShowStatsWhenSelectKey = 'settings/show_stats_when_select';

abstract class AppSettings {

  static double newDesignOpacity = 0.7;
  static bool get useNewStyle => newDesignOpacity>0.1;
  static bool _useNewPopup = true;
  static bool get useNewPopup => _useNewPopup;
  static bool _showStatsWhenSelect = true;
  static bool get showStatsWhenSelect => _showStatsWhenSelect;
  static bool _commentCasualFont = false;
  static bool get commentCasualFont => _commentCasualFont;

  static SharedPreferences get prefs => AppSharedPreference.prefs;

  static init(){
    AppSettings.newDesignOpacity = prefs.getDouble(_newDesignKey) ?? 0.75;
    AppSettings._useNewPopup = prefs.getBool(_newPopupKey) ?? true;
    AppSettings._showStatsWhenSelect = prefs.getBool(_newShowStatsWhenSelectKey) ?? true;
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

  static updateShowStatsWhenSelect(bool value){
    _showStatsWhenSelect = value;
    prefs.setBool(_newShowStatsWhenSelectKey, value);
  }

  static bool getAppVersion(){
    var result = prefs.getBool('app_$appVersion')??false;
    if(!result){
      prefs.setBool('app_$appVersion', true);
    }
    return result;
  }

  static Map<String, Object> metrica()=>{
    'useNewStyle':newDesignOpacity,
    'useNewPopup':useNewPopup,
    'showStatsWhenSelect':showStatsWhenSelect,
    'commentCasualFont':commentCasualFont,
  };

}