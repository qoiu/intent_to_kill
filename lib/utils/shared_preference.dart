
import 'package:flutter/foundation.dart';
import 'package:qoiu_utils/qoiu_utills.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _countKey = 'count';
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

  static int startGame(){
    var old = prefs.getInt(_countKey)??0;
    prefs.setInt(_countKey, ++old);
    return old;
  }

}