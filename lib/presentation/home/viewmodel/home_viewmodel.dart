import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elmuslim_app/presentation/home/screens/adhkar/view/adhkar_screen.dart';
import 'package:elmuslim_app/presentation/home/screens/hadith/view/hadith_screen.dart';
import 'package:elmuslim_app/presentation/home/screens/quran/view/quran_screen.dart';
import 'package:elmuslim_app/presentation/home/screens/settings/view/settings_screen.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';

class HomeViewModel {
  HomeViewModel();

  int currentIndex = 0;

  List<Widget> screens = [
    const QuranScreen(),
    const HadithScreen(),
    const AdhkarScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    AppStrings.quran.tr(),
    AppStrings.nawawi.tr(),
    AppStrings.adhkarDoaa.tr(),
    AppStrings.settings.tr(),
  ];
}
