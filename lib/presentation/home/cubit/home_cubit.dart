import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:elmuslim_app/app/utils/app_prefs.dart';
import 'package:elmuslim_app/app/utils/di.dart';

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


  bool isPageBookMarked(int quranPageNumber) {
    return _preferences.isPageBookMarked(quranPageNumber);
  }

  // bool isThereABookMarkedPage = false;

  Future<bool> isThereABookMarked()async  {
    bool isThereABookMarkedPage = false;

    await _preferences.isThereABookMarked().then((value) => isThereABookMarkedPage = value);

    // await getQuranData();
    print(isThereABookMarkedPage);
    emit(CheckQuranBookMarkPageState());
    return isThereABookMarkedPage;
  }

  Future<void> bookMarkPage(int quranPageNumber) async {
    // isPageBookMarked = !isPageBookMarked;
    if (!isPageBookMarked(quranPageNumber)) {
      _preferences.bookMarkPage(quranPageNumber);
    } else {
      _preferences.removeBookMarkPage();
    }
    await isThereABookMarked();
    emit(QuranBookMarkPageState());

  }

  int? bookMarkedPage;

  int? getBookMarkPage() {
    // isPageBookMarked = !isPageBookMarked;
    bookMarkedPage = _preferences.getBookMarkedPage();
    emit(GetQuranBookMarkPageState());
    return bookMarkedPage;
  }
}
