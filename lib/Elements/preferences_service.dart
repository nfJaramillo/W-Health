import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:w_health/Models/preferences.dart';

abstract class PreferencesService {
  Preferences get();
  Future<void> set(Preferences preferences);
  Future<void> clear();
}

class MyPreferencesService implements PreferencesService {
  static const PREFS_KEY = "prefs";

  final SharedPreferences _sharedPreferences;

  MyPreferencesService(this._sharedPreferences);

  @override
  Future<void> clear() async => _sharedPreferences.clear();

  @override 
  Preferences get() {
    final data = _sharedPreferences.getString(PREFS_KEY);
    if(data == null){
      return Preferences.defaultValues();
    }

    final map = Map<String, dynamic>.from(jsonDecode(data));
    return Preferences.defaultValues();
  }

  @override
  Future<void> set(Preferences preferences) async {
    final data = jsonEncode(preferences.toJson());
    await _sharedPreferences.setString(PREFS_KEY, data);
  }
}
