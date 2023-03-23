import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/presentation/resources/language_manager.dart';
import 'package:islamic_app/presentation/resources/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsLangKey = "LANG_KEY";
const String themeModeKey = "THEME_MODE_KEY";

class AppPreferences {
  final SharedPreferences _preferences = instance<SharedPreferences>();

  AppPreferences();

  Future<String> getAppLanguage() async {
    String? language = _preferences.getString(prefsLangKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.arabic.getValue();
    }
  }

  Future changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      _preferences.setString(prefsLangKey, LanguageType.english.getValue());
    } else {
      _preferences.setString(prefsLangKey, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getAppLocale() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<ThemeMode> getAppTheme() async {
    String? themeMode = _preferences.getString(themeModeKey);
    if (themeMode != null && themeMode.isNotEmpty) {
      if (themeMode == ThemeType.dark.getValue()) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.system;
    }
  }

  Future changeAppTheme() async {
    ThemeMode currentTheme = await getAppTheme();
    if (currentTheme == ThemeMode.dark) {
      _preferences.setString(themeModeKey, ThemeType.light.getValue());
    } else {
      _preferences.setString(themeModeKey, ThemeType.dark.getValue());
    }
  }
}
