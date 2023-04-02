import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:islamic_app/app/utils/app_prefs.dart';
import 'package:islamic_app/app/utils/di.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppPreferences _preferences = instance<AppPreferences>();

  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBotNavIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBotNavIndexState());
  }

  late bool isDarkModeOn;

  bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    print(brightness);
    isDarkModeOn = brightness == Brightness.dark ? true : false;
    return isDarkModeOn;
  }

  bool darkModeOn(BuildContext context) {
    final currentThemeMode = _preferences.getAppTheme();
    return currentThemeMode == ThemeMode.dark;
  }

  void changeAppTheme() {
    _preferences.changeAppTheme();

    emit(HomeChangeAppThemeState());
  }

  void changeAppLanguage(BuildContext context) {
    _preferences.changeAppLanguage();
    Phoenix.rebirth(context);
    emit(HomeChangeAppLanguageState());
  }
}
