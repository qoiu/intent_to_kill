
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference{

  const AppSharedPreference();

  static SharedPreferences? _prefs;

  static Future init()async{
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences _checkPrefs(){
    if(_prefs==null)throw Exception('Please, call AppSharedPreference.init(); before');
    return _prefs!;
  }

  static SharedPreferences get prefs=>_checkPrefs();

}