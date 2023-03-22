import 'dart:ui';

import 'package:islamic_app/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String prefsLangKey = "LANG_KEY";
const String themeModeKey = "THEME_MODE_KEY";
class AppPreferences{
  final SharedPreferences _preferences;

  AppPreferences(this._preferences);

  Future<String> getAppLanguage() async {
    String? language = _preferences.getString(prefsLangKey);
    if(language != null && language.isNotEmpty){
      return language;
    } else{
      return LanguageType.arabic.getValue();
    }
  }

  Future changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.arabic.getValue()) {
      _preferences.setString(prefsLangKey, LanguageType.english.getValue());
    } else {
      _preferences.setString(prefsLangKey, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getAppLocale() async {
    String currentLanguage = await getAppLanguage();
    if(currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }
}