import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/presentation/base/base_view_model.dart';
import 'package:islamic_app/presentation/home/cubit/home_cubit.dart';
import 'package:islamic_app/presentation/home/screens/azkar/view/azkar_screen.dart';
import 'package:islamic_app/presentation/home/screens/hadith/view/hadith_screen.dart';
import 'package:islamic_app/presentation/home/screens/quran/view/quran_screen.dart';
import 'package:islamic_app/presentation/home/screens/settings/view/settings_screen.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';

class HomeViewModel extends BaseViewModel {
  final HomeCubit _cubit = instance<HomeCubit>();

  HomeViewModel();

  int currentIndex = 0;

  List<Widget> screens = [
    const QuranScreen(),
    const HadithScreen(),
    const AzkarScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    AppStrings.quran.tr(),
    AppStrings.hadith.tr(),
    AppStrings.azkar.tr(),
    AppStrings.settings.tr(),
  ];

  // void changeBotNavIndex(int index) {
  //   _cubit.changeBotNavIndex(currentIndex, index);
  // }

  Future<List<QuranModel>> getQuranData() async {
    final List<QuranModel> data = await _cubit.getQuranData();
    return data;
  }

  Future<List<HadithModel>> getHadithData() async {
    final List<HadithModel> data = await _cubit.getHadithData();
    return data;
  }

  Future<List<AzkarModel>> getAzkarData() async {
    final List<AzkarModel> data = await _cubit.getAzkarData();
    return data;
  }
}